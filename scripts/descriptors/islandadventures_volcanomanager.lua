--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- volcanomanager.lua [Worldly]
local function Describe(self, context)
	-- SW only
	local description = nil
	local time_string = nil
	local warning = nil

	if not ( self:GetNumSegmentsUntilEruption() and self:GetNumSegmentsUntilQuake() ) then
		return
	end

	local ActualTime = (TUNING.TOTAL_DAY_TIME * (TheWorld.state.time * 100)) / 100
	local ActualSeg = math.floor(ActualTime / 30)
	local TimeInSeg = ActualTime - (ActualSeg * 30)

	local SegUntilEruption = self:GetNumSegmentsUntilEruption() or 0
	local seconds = math.floor((SegUntilEruption * 30) - TimeInSeg)
	seconds = math.floor(seconds + 0.5)

	local SegUntilQuake = self:GetNumSegmentsUntilQuake() or 0
	local next_quake = math.floor((SegUntilQuake * 30) - TimeInSeg)
	next_quake = math.floor(next_quake + 0.5)

	time_string = string.format(
		STRINGS.Compat_Insight.VOLCANOMANAGER.ANNOUNCE_COOLDOWN,
		context.time:SimpleProcess(seconds)
	)

	warning = seconds <= 30 and true or false
	description = string.format(
		STRINGS.Compat_Insight.VOLCANOMANAGER.DESCRIPTION,
		context.time:SimpleProcess(seconds),
		context.time:SimpleProcess(next_quake)
	)

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Volcano.xml",
			tex = "Volcano.tex"
		},
		worldly = true,
		warning = warning,
		time_string = time_string
	}
end

local function StatusAnnouncementsDescribe(special_data, context)
    if not special_data.time_string then
        return
    end

    return {
        description = special_data.time_string,
        append = true
    }
end

local function DangerAnnouncementDescribe(special_data, context)
	if not special_data.time_string then
		return
	end

	return special_data.time_string
end

return {
	Describe = Describe,
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe,
	DangerAnnouncementDescribe = DangerAnnouncementDescribe
}