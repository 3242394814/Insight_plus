--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- krakener.lua
local function Describe(self, context)
	-- this is attached to player, but GetWorldInformation extracts it anyway
	local description = nil
	local status_string = nil

	local respawn_time = self:TimeUntilCanSpawn()

	if respawn_time > 0 then
		description = context.time:SimpleProcess(respawn_time)
		status_string = Insight.env.ProcessRichTextPlainly(string.format(
			STRINGS.Compat_Insight.KRAKENER.ANNOUNCE_TIMER,
			description
		))
	end

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Kraken.xml",
			tex = "Kraken.tex",
		},
		status = status_string
	}
end

local function StatusAnnoucementsDescribe(special_data, context)
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
	StatusAnnoucementsDescribe = StatusAnnoucementsDescribe
}