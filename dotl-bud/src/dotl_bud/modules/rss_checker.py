from .variables import VariableCommands

import feedparser
import logging as log
import datetime
from discord import Forbidden, HTTPException


class RSSChecker(VariableCommands):

    def __init__(self, client, *args, **kwargs):
        super(RSSChecker, self).__init__(client, *args, **kwargs)

    def is_announceable(self, item):
        # Low-traffic enough that we can just post everything
        return True

    async def check_rss(self,
                        url,
                        channel,
                        message_template,
                        tag,
                        pin_message=False,
                        mention_role=None):
        feed = feedparser.parse(url)
        # bluesky returns items in unsorted order, so we need to sort by date manually
        items = sorted(
            feed["items"], key=lambda item: item["published_parsed"], reverse=True)
        item = items[0]  # Most recent

        if not self.is_announceable(item):
            return

        current_link = str(item["link"]).strip()
        dbitem = ("last_link_" + tag, )
        last_link = self.db[dbitem].strip()
        if current_link == last_link:
            return

        log.info(f"new: {current_link} old: {last_link}")
        self.db[dbitem] = current_link

        channel_obj = self.client.get_channel(channel)

        formatted_message = message_template.replace(
            "%page%", item["link"])
        formatted_message = formatted_message.replace(
            "%description%",
            item.get("description", "[missing description]"))

        if not (mention_role is None):
            formatted_message = formatted_message.replace(
                "%mention%",
                channel_obj.guild.get_role(mention_role).mention)
        message = await self.send_simple_message(
            formatted_message, self.client.get_channel(channel))
        if pin_message:
            await message.pin()

    async def delete_previous_pins(self, channel, cutoff_age):
        """
        It is recommened you schedule this function once a day
        if you set pin_message=True in check_rss
        """

        curtime = datetime.datetime.now(datetime.timezone.utc)

        pins = await self.client.get_channel(channel).pins()

        # Filter so we only unpin messages we sent cutoff_age ago
        # Could compare direct user objects, but I don't trust that...
        my_old_pins = filter(
            lambda p: (p.created_at + cutoff_age < curtime) and
            (p.author.id == self.client.user.id),
            pins
        )

        for message in my_old_pins:
            try:
                await message.unpin()
            except (Forbidden, HTTPException):
                log.warning("Could not unpin message {} ({})".format(
                    message.id, message.timestamp))
