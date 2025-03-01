--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Above the Clouds
]]

-- aporkalypse.lua [Worldly]
local function Describe(self, context)
	local description
	local warning
	local status_string
	local Next_Aporkalypse_Time = Insight.env.util.getupvalue(self.OnUpdate, "_timeuntilaporkalypse")

	if not Next_Aporkalypse_Time then return end

	Next_Aporkalypse_Time = Next_Aporkalypse_Time:value()
	if Next_Aporkalypse_Time > 0 then
		warning = Next_Aporkalypse_Time <= 30 and true or false
		description = context.time:SimpleProcess(Next_Aporkalypse_Time)
		status_string = string.format(
			STRINGS.Compat_Insight.APORKALYPSE.NEXT_TIME,
			description
		)
	else
		warning = false
		local next_bat_attack = Insight.env.util.getupvalue(self.OnUpdate, "_bat_time")
		local next_herald_attack = Insight.env.util.getupvalue(self.OnUpdate, "_herald_time")

		if not (next_bat_attack and next_herald_attack) then return end

		next_bat_attack = context.time:SimpleProcess(next_bat_attack)
		next_herald_attack = context.time:SimpleProcess(next_herald_attack)

		description = string.format(
			STRINGS.Compat_Insight.APORKALYPSE.ATTACK,
			next_bat_attack,
			next_herald_attack
		)
		status_string = description
	end


	return {
		priority = 0,
		description = description,
		worldly = true,
		icon = {
			atlas = "images/Aporkalypse_Clock.xml",
			tex = "Aporkalypse_Clock.tex",
		},
		warning = warning,
		status = status_string
	}
end

local function StatusAnnouncementsDescribe(special_data, context)
    if not special_data.status then
        return
    end

    local description = nil

    description = special_data.status

    return {
        description = description,
        append = true
    }
end

local function DangerAnnouncementDescribe(special_data, context)
	if not special_data.status then
		return
	end

	return special_data.status
end

return {
	Describe = Describe,
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe,
	DangerAnnouncementDescribe = DangerAnnouncementDescribe
}