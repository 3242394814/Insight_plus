--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- volcanomanager.lua [Worldly]
local clock = Insight.env.import("helpers/clock")
local function Describe(self, context)
	-- SW only
	local description = nil
	local time_string = nil
	local warning = nil

	local time_left_in_segment = clock:GetTimeLeftInSegment()
	if not time_left_in_segment then
		return
	end

	if not self:GetNumSegmentsUntilEruption() then
		return
	end

	local seconds = (self:GetNumSegmentsUntilEruption() - 1) * TUNING.SEG_TIME + time_left_in_segment
	local next_quake = ((self:GetNumSegmentsUntilQuake() - 1) * TUNING.SEG_TIME + time_left_in_segment) or 0 -- 下次地震时间


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