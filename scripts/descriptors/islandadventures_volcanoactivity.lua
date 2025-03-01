--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- volcanoactivity.lua [Worldly]
local function Describe(self, context)
	-- SW only
	local description = nil
	local time_string = nil
	local _eruption = Insight.env.util.getupvalue(self.OnUpdate, "_eruption") -- 火山是否正在爆发
	local _eruption_timer = Insight.env.util.getupvalue(self.OnUpdate, "_eruption_timer") -- 火山爆发计时器
	local _firerain_duration = Insight.env.util.getupvalue(self.OnUpdate, "_firerain_duration") -- 火山爆发持续时间

	local _minor_eruption = Insight.env.util.getupvalue(self.OnUpdate, "_minor_eruption") -- 火山是否正在小规模爆发(玩家使用火山魔杖召唤的爆发)
	local _minor_firerains_data = Insight.env.util.getupvalue(self.OnUpdate, "_minor_firerains_data") -- 小规模喷发数据
	-- local _minor_eruption_timer = Insight.env.util.getupvalue(self.OnUpdate, "_minor_eruption_timer") -- 火山小规模爆发计时器

	if not _eruption:value() and not _minor_eruption:value() then return end

	-- 火山爆发
	if _eruption:value() then
		local remaining_time = _firerain_duration - _eruption_timer:value()

		description = string.format(
			STRINGS.Compat_Insight.VOLCANOACTIVITY.EROPTION,
			context.time:SimpleProcess(remaining_time)
		)

		time_string = string.format(
			STRINGS.Compat_Insight.VOLCANOACTIVITY.ANNOUNCE_EROPTION,
			context.time:SimpleProcess(remaining_time)
		)

	else
		description = STRINGS.Compat_Insight.VOLCANOACTIVITY.NO_EROPTION
	end

	-- 小型火山爆发（使用火山魔杖召唤的）
	if _minor_eruption:value() then
		for index, data in pairs(_minor_firerains_data) do
			description = description .. string.format(
				STRINGS.Compat_Insight.VOLCANOACTIVITY.MINOR_EROPTION,
				index, data.count
			)
		end
	else
		description = description .. STRINGS.Compat_Insight.VOLCANOACTIVITY.NO_MINOR_EROPTION
	end

	return {
		priority = 1,
		description = description,
		icon = {
			atlas = "images/Volcano_Active.xml",
			tex = "Volcano_Active.tex"
		},
		worldly = true,
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

return {
	Describe = Describe,
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe
}