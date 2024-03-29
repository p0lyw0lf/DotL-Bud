import re
from discord import Embed

class Shell:
    def __init__(self, client, *args, **kwargs):
        super(Shell, self).__init__(self, client, *args, **kwargs)
        self.admins = {172823011999744001,}

        self.special_begin = 'b!'
        self.tokenizing_regex = re.compile("([^\s\"']+|\"([^\"]*)\"|'([^']*)')")
        self.commands = dict()
        self.dm_allowed_commands = set()
        self.databases = []

        self.force_words = {"force", "-f", "--force", "justdoit"}
        self.yes_words = {"true", "1", "yes", "-y", "--yes", "yup"}
        self.no_words = {"false", "0", "no", "-n", "--no", "nope"}

        self.client = client

    def tokenize(self, message):
        groups = self.tokenizing_regex.findall(message)
        groups = [x[2] if x[2] else x[1] if x[1] else x[0] for x in groups]
        return groups

    def is_yes(self, string):
        return self.autocomplete(string.lower(), self.yes_words) in self.yes_words

    def is_no(self, string):
        return self.autocomplete(string.lower(), self.no_words) in self.no_words

    def is_force(self, string):
        return string.lower() in self.force_words

    def autocomplete(self, string, iterable):
        for thing in iterable:
            if isinstance(thing, str) and thing.startswith(string):
                return thing
        return string

    def format_embed_unsafe(self, user, response):
        output = Embed()
        output.color = 0x0da000
        output.set_author(name=user.display_name, icon_url=user.avatar_url)
        if isinstance(response, str):
            output.description = response
        elif isinstance(response, dict):
            for field in response:
                if field == 'desc':
                    output.description = response[field]
                else:
                    output.add_field(name=field, value=response[field])
        else:
            # response is probably embed already
            return response

        return output
        
    def format_embed(self, user, response):
        """
        Returns a single embed or list of embeds depending on
        if the content will go over the limit or not.
        """
        if isinstance(response, str):
            if len(response) <= 2048:
                return self.format_embed_unsafe(user, response)
            else:
                return [
                    self.format_embed_unsafe(user, response[x:x+2048])
                    for x in range(0, len(response), 2048)
                ]
        elif isinstance(response, dict):
            if len(response) <= 25:
                return self.format_embed_unsafe(user, response)
            else:
                sorted_keys = sorted(response.keys())
                return [
                    self.format_embed_unsafe(user, {key: response[key] for key in sorted_keys[x:x+25]})
                    for x in range(0, len(sorted_keys), 25)
                ]
        else:
            return response

    async def send_message(self, response, user, channel):
        output = self.format_embed(user, response)
        return await channel.send(embed=output)

    async def send_simple_message(self, response, channel):
        return await channel.send(response)

    async def update_message(self, response, message_obj, user, channel):
        output = self.format_embed(user, response)
        return await message_obj.edit(embed=output)

    async def update_simple_message(self, response, message_obj, channel):
        return await message_obj.edit(response)

    async def commit_dbs(self):
        for db in self.databases:
            db.commit()
