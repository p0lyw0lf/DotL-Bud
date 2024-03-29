import traceback
from discord import Forbidden
from discord.errors import NotFound
import discord
import asyncio
import sys

from modules.help import HelpCommands
from modules.dice import DiceCommands
from modules.misc import MiscCommands
from modules.permissions import Permissions
from modules.memes import MemeCommands
from modules.role_manager import RoleManager
from utils import safe_int, safe_float

class Parser(MiscCommands, HelpCommands, DiceCommands, MemeCommands, RoleManager):
    # I'm hoping to do NLP someday, but idk what I need to do
    # in order to make compatibility for it...
    def __init__(self, client, *args, **kwargs):
        super(Parser, self).__init__(client, *args, **kwargs)

    def full_tokenize(self, message):
        message = message[len(self.special_begin):] if message.startswith(self.special_begin) else message
        tokens = self.tokenize(message)
        command = tokens[0] #self.autocomplete(tokens[0], self.commands)
        tokens = tokens[1:][::-1]
        return command, tokens

    def get_args(self, command, tokens, message, user, server, channel):
        args = []
        mention_index = 0
        for index in range(len(self.commands[command]["args"])):
            arg = self.commands[command]['args'][index]

            if arg == "user":
                args.append(user)

            elif arg == "message":
                args.append(message)

            elif arg == "server":
                args.append(server)

            elif arg == "channel":
                args.append(channel)

            elif arg == "mention":
                if mention_index < len(message.mentions):
                    args.append(message.mentions[mention_index].id)
                    mention_index += 1
                else:
                    args.append(None)

            elif arg == '*mentions':
                args.append([p.id for p in message.mentions])

            elif len(tokens) != 0:

                if arg == 'force?':
                    args.append(self.autocomplete(tokens.pop().lower(), self.force_words))
                elif arg == 'no?':
                    args.append(self.autocomplete(tokens.pop().lower(), self.no_words))
                elif arg == 'yes?':
                    args.append(self.autocomplete(tokens.pop().lower(), self.yes_words))
                elif arg == 'str':
                    args.append(tokens.pop())
                elif arg == '*str':
                    args.append([tokens.pop().lower() for x in
                                    range(len(tokens) - (len(self.commands[command]['args']) - index - 1))])

                elif arg == 'int':
                    args.append(safe_int(tokens.pop()))
                elif arg == 'float':
                    args.append(safe_float(tokens.pop()))


        return args

    async def wait_then_delete(self, message, user):
        wait_time = safe_float(self.db[user.id, 'delete_response_time'])
        await asyncio.sleep(wait_time)
        try:
            await message.delete()
        except (Forbidden, NotFound):
            pass

    async def parse(self, message_obj):
        try:

            message = message_obj.content.split('\n')[0]
            server = message_obj.guild
            channel = message_obj.channel
            user = message_obj.author

            if message.startswith(self.special_begin) or \
               (channel.type == discord.ChannelType.private and user.id != self.client.user.id):

                command, tokens = self.full_tokenize(message)

                if command in self.commands:
                    if self.can_run_command(user, server, command):

                        args = self.get_args(command, tokens, message_obj, user, server, channel)
                        output = await self.commands[command]["func"](*args)

                        return command, output
                    else:
                        return command, "You do not have permission to run that command"

                else:
                    return command, "The command {} does not exist.".format(message)

            return None, None

        except Exception as e:
            traceback.print_exc()
            return "An {} was thrown.".format(type(e))

    async def clear_all(self, user, channel, force=False):
        if user.id not in self.admins:
            return "Nope, you can't do that"
        if force:
            await self.client.purge_from(channel)
        else:
            return "Are you sure? Use `b!clear force` to do it for real"
