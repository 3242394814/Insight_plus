--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Island Adventures - Shipwrecked. 
]]

-- chessnavy.lua [Worldly]
local function Describe(self, context)
	-- SW only
	local description = nil
	local status_string = nil

	if self.spawn_timer and self.spawn_timer > 0 then
		description = string.format(context.lstr.chessnavy_timer, context.time:SimpleProcess(self.spawn_timer))
		status_string = Insight.env.ProcessRichTextPlainly(string.format(
			STRINGS.Compat_Insight.CHESSNAVY.ANNOUNCE_TIMER,
			description
		))
	elseif self.ready_to_spawn then
		description = context.lstr.chessnavy_ready
		status_string = Insight.env.ProcessRichTextPlainly(string.format(
			STRINGS.Compat_Insight.CHESSNAVY.ANNOUNCE_READY,
			description
		))
	end

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Knightboat.xml",
			tex = "Knightboat.tex"
		},
		worldly = true,
		status = status_string
	}
end

local function StatusAnnouncementsDescribe(special_data, context)
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
	StatusAnnouncementsDescribe = StatusAnnouncementsDescribe
}