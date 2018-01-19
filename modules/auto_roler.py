import datetime
import logging as log

import discord
from discord import Forbidden, HTTPException


class AutoRoler():
    def __init__(self, client, *args, **kwargs):
        super(AutoRoler, self).__init__(client, *args, **kwargs)
        
    async def check_roles(self, serverid, roleid, timelimit, *_, previous_roleid=None):
        curtime = datetime.datetime.utcnow()
        
        server = self.client.get_server(serverid)
        if server.large:
            await self.client.request_offline_members(server)
        role = discord.utils.get(server.roles, id=roleid)
        
        if previous_roleid is None:
            previous_role = server.default_role
        else:
            previous_role = discord.utils.get(server.roles, id=previous_roleid)
            
        for member in server.members:
            if member.joined_at + timelimit < curtime:
                if previous_role in member.roles and role not in member.roles:    
                    log.debug(str(member)+": "+str(member.joined_at)+" | "+str(curtime)+" | "+str(member.joined_at+timelimit))
                    try:
                        await self.client.add_roles(member, role)
                        log.info("[SUCCESS] Changing role of "+str(member)+" succeeded")
                    except (Forbidden, HTTPException) as e:
                        log.info("[FAILURE] Changing role of "+str(member)+" failed")
