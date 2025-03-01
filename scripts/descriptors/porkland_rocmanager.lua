--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Above the Clouds
]]

-- rocmanager.lua [Worldly]
local function Describe(self, context)
	local description
	local str = self:GetDebugString()
	local remaining_time = string.match(str,"Spawns In: ([%d%.%-]+)")
	local IsPaused = string.match(str, "%(Paused%)")

	if not remaining_time then return end

	remaining_time = tonumber(remaining_time)
	local warning = remaining_time <= 30 and true or false

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

local function StatusAnnouncementsDescribe(special_data, context)
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
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe,
	DangerAnnouncementDescribe = DangerAnnouncementDescribe,
}