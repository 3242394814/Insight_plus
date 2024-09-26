--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Above the Clouds
]]

-- rocmanager.lua [Worldly]
local ROC_TIMER_NAME = "ROC_RESPAWN_TIMER"
local IsPaused = TheWorld.components.worldsettingstimer:IsPaused(ROC_TIMER_NAME)

local function Describe(self, context)
	local description
	local remaining_time = TheWorld.components.worldsettingstimer:GetTimeLeft(ROC_TIMER_NAME) or -1
	local warning = remaining_time<=30 and true or false

	description = context.time:SimpleProcess(remaining_time)

	if IsPaused then
		description = description .. STRINGS.Compat_Insight.ROCMANAGER.PAUSED
	end

	local status_string = description

	return {
		priority = 0,
		description = description,
		time_to_attack = status_string,
		warning = warning,
		worldly = true,
		icon = {
			atlas = "images/Roc.xml",
			tex = "Roc.tex",
		},
	}
end

local function StatusAnnoucementsDescribe(special_data, context)
	if not special_data.time_to_attack then
		return
	end

	local description = nil

	description = Insight.env.ProcessRichTextPlainly(string.format(
		STRINGS.Compat_Insight.ROCMANAGER.ROC_ATTACK,
		special_data.time_to_attack
	))

	return {
		description = description,
		append = true
	}
end

local function DangerAnnouncementDescribe(special_data, context)
	if not special_data.time_to_attack then
		return
	end

	local description = nil

	description = Insight.env.ProcessRichTextPlainly(string.format(
		STRINGS.Compat_Insight.ROCMANAGER.ROC_ATTACK,
		special_data.time_to_attack
	))

	return description, "boss"
end

return {
	Describe = Describe,
	StatusAnnoucementsDescribe = StatusAnnoucementsDescribe,
	DangerAnnouncementDescribe = DangerAnnouncementDescribe,
}