--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Above the Clouds
]]

-- banditmanager.lua [Worldly]
local function Describe(self, context)
	local description

	local str = self:GetDebugString()
	local stolen_oincs, active_bandit, respawns_in = string.match(str, "Stolen Oincs: (%d+) Active Bandit: (%a+) Respawns In: ([%d%.%-]+)")

	if not (stolen_oincs and active_bandit and respawns_in) then return end

	respawns_in = context.time:SimpleProcess(tonumber(respawns_in))

	description = string.format(
		STRINGS.Compat_Insight.BANDITMANAGER.DESCRIPTION,
		respawns_in,
		stolen_oincs,
		active_bandit
	)

	return {
		priority = 0,
		description = description,
		worldly = true,
		icon = {
			atlas = "images/pig_bandit.xml",
			tex = "pig_bandit.tex",
		},
		status = {
			active_bandit = active_bandit, -- 是否有盗贼
			stolen_oincs = stolen_oincs, -- 被盗呼噜币数量
			respawns_in = respawns_in -- 重生倒计时
		}
	}
end

local function StatusAnnouncementsDescribe(special_data, context)
    if not special_data.status then
        return
    end

    local description = nil
	local status = nil

    status = special_data.status

	if status.active_bandit == "true" then
		description = string.format(
			STRINGS.Compat_Insight.BANDITMANAGER.ANNOUNCE_READY,
			status.stolen_oincs
		)
	else
		description = string.format(
			STRINGS.Compat_Insight.BANDITMANAGER.ANNOUNCE_COOLDOWN,
			status.respawns_in,
			status.stolen_oincs
		)
	end

    return {
        description = description,
        append = true
    }
end

return {
	Describe = Describe,
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe
}