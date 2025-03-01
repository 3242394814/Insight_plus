--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- tigershark.lua [Worldly]
local function Describe(self, context)
	-- SW only
	local description = nil

	local appear_time = self:TimeUntilCanAppear()
	local respawn_time = self:TimeUntilRespawn()

	--dprint("appear:", self:TimeUntilCanAppear(), "respawn:", self:TimeUntilRespawn(), "shark:", self.shark)

	if self.shark then
		description = context.lstr.tigershark_exists
	elseif self:CanSpawn(true, true) then
		-- something has to trigger a spawn
		if appear_time > 0 or respawn_time > 0 then
			local max = math.max(appear_time, respawn_time)
			description = string.format(context.lstr.tigershark_spawnin, context.time:SimpleProcess(max))
		else
			description = context.lstr.tigershark_waiting
		end
	else
		description = string.format("?No Spawn Possible?")
	end

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Tigershark.xml",
			tex = "Tigershark.tex"
		},
		worldly = true,
		status = Insight.env.ProcessRichTextPlainly("<prefab=tigershark>: "..description)
	}
end

local function StatusAnnouncementsDescribe(special_data, context)
    if not special_data.status then
        return
    end

    return {
        description = special_data.status,
        append = true
    }
end

return {
	Describe = Describe,
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe
}