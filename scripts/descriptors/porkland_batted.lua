--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Above the Clouds
]]

-- batted.lua [Worldly]
local function Describe(self, context)
	local description
	local warning
	local bat_count = TheWorld.components.batted:GetNumBats()
	local regen_in = Insight_Plus_Upvaluehelper.GetUpvalue(self.LongUpdate, "_bat_regen_time")
	local next_attack_in = Insight_Plus_Upvaluehelper.GetUpvalue(self.LongUpdate, "_bat_attack_time")

	if not (bat_count and regen_in and next_attack_in) then return end

	warning = next_attack_in <= 30 and true or false
	regen_in = context.time:SimpleProcess(regen_in)
	next_attack_in = context.time:SimpleProcess(next_attack_in)

	description = string.format(
		STRINGS.Compat_Insight.BATTED.DESCRIPTION,
		next_attack_in,
		bat_count,
		regen_in
	)

	return {
		priority = 0,
		description = description,
		worldly = true,
		icon = {
			atlas = "images/Vampirebat.xml",
			tex = "Vampirebat.tex",
		},
		warning = warning,
		countdown = next_attack_in,
	}
end

local function StatusAnnouncementsDescribe(special_data, context)
    if not special_data.countdown then
        return
    end

    local description = nil

    description = Insight.env.ProcessRichTextPlainly(string.format(
        STRINGS.Compat_Insight.BATTED.NEXT_ATTACK,
        special_data.countdown
    ))

    return {
        description = description,
        append = true
    }
end

local function DangerAnnouncementDescribe(special_data, context)
	if not special_data.countdown then
		return
	end

	local time_string = special_data.countdown

	return string.format(
		STRINGS.Compat_Insight.BATTED.NEXT_ATTACK,
		time_string
	)
end

return {
	Describe = Describe,
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe,
	DangerAnnouncementDescribe = DangerAnnouncementDescribe
}