--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- volcanomanager.lua [Worldly]
local clock = Insight.env.import("helpers/clock")
local function Describe(self, context)
	local description = nil
	local warning = nil
	local next_quake = nil
	local next_eruption = nil
	local time_string = nil

	local firerain_timer = self.firerain_timer
	local firerain_delay = self.firerain_delay
	local firerain_duration = self.firerain_duration
	local firerain_intensity = self.firerain_intensity

	local ash_timer = self.ash_timer
	local ash_delay = self.ash_delay
	local ash_duration = self.ash_duration

	local smoke_timer = self.smoke_timer
	local smoke_delay = self.smoke_delay
	local smoke_duration = self.smoke_duration

	if not (self:GetNumSegmentsUntilQuake() and self:GetNumSegmentsUntilEruption() and firerain_timer and ash_timer and smoke_timer) then
		return
	end

	if firerain_timer <= 0 and ash_timer <= 0 and smoke_timer <= 0 then
		local time_left_in_segment = clock:GetTimeLeftInSegment()
		if not time_left_in_segment then
			return
		end

		next_quake = (self:GetNumSegmentsUntilQuake() - 1) * TUNING.SEG_TIME + time_left_in_segment
		next_eruption = (self:GetNumSegmentsUntilEruption() - 1) * TUNING.SEG_TIME + time_left_in_segment
		time_string = string.format(
			STRINGS.Compat_Insight.VOLCANOMANAGER.ANNOUNCE_COOLDOWN,
			context.time:SimpleProcess(next_eruption)
		)

		warning = next_eruption <= 30 and true or false
		description = string.format(
			STRINGS.Compat_Insight.VOLCANOMANAGER.DESCRIPTION,
			context.time:SimpleProcess(next_eruption),
			context.time:SimpleProcess(next_quake)
		)
	else
		warning = false
		if firerain_timer > 0 then
			time_string = string.format(
				STRINGS.Compat_Insight.VOLCANOMANAGER.ANNOUNCE_QUAKE,
				context.time:SimpleProcess(firerain_timer)
			)
		elseif smoke_timer > 0 then
			time_string = string.format(
				STRINGS.Compat_Insight.VOLCANOMANAGER.ANNOUNCE_SMOKETIME,
				context.time:SimpleProcess(smoke_timer)
			)
		elseif ash_timer > 0 then
			time_string = string.format(
				STRINGS.Compat_Insight.VOLCANOMANAGER.ANNOUNCE_ASHTIME,
				context.time:SimpleProcess(ash_timer)
			)
		end

		description = string.format(
			STRINGS.Compat_Insight.VOLCANOMANAGER.QUAKE_INFO,
			firerain_timer,firerain_delay,firerain_duration,firerain_intensity,
			ash_timer,ash_delay,ash_duration,
			smoke_timer,smoke_delay,smoke_duration
		)
	end

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Volcano.xml",
			tex = "Volcano.tex"
		},
		worldly = true,
		warning = warning,
		countdown = time_string
	}
end

local function StatusAnnoucementsDescribe(special_data, context)
    if not special_data.countdown then
        return
    end

    return {
        description = special_data.countdown,
        append = true
    }
end

local function DangerAnnouncementDescribe(special_data, context)
	if not special_data.countdown then
		return
	end

	return special_data.countdown
end

return {
	Describe = Describe,
	StatusAnnoucementsDescribe = StatusAnnoucementsDescribe,
	DangerAnnouncementDescribe = DangerAnnouncementDescribe
}