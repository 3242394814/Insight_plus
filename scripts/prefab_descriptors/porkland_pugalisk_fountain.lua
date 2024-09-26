--[[
-Code courtesy of penguin0616. Most (Almost all, actually) belongs to Insight. https://steamcommunity.com/sharedfiles/filedetails/?id=2189004162
Adapted for Above the Clouds
]]

-- pugalisk_fountain.lua [Prefab]
local function Describe(self, context)
    if self.resettaskinfo then
        local seconds = self:TimeRemainingInTask(self.resettaskinfo)
        local description = Insight.env.ProcessRichTextPlainly(string.format(
            STRINGS.Compat_Insight.PUGALISK_FOUNTAIN.WATERDROP_REGEN,
            context.time:SimpleProcess(seconds)
        ))

        return {
            priority = 0,
            description = description,
        }
    end
    return nil
end

local function GetRespawnTime(self)
    if self.resettaskinfo then
        local description = self:TimeRemainingInTask(self.resettaskinfo)
        return {
            priority = 0,
            description = description,
        }
    end
    return nil
end

local function RemoteDescribe(data, context)
    local description = Insight.env.ProcessRichTextPlainly(string.format(
        STRINGS.Compat_Insight.PUGALISK_FOUNTAIN.WATERDROP_REGEN,
        context.time:SimpleProcess(data.description)
    ))

    return {
        priority = 0,
        description = description,
        icon = {
            atlas = "images/lifeplant.xml",
            tex = "lifeplant.tex",
        },
        worldly = true, -- meeeh
        prefably = true,
        from = "prefab",
        time_to_respawn = description
    }
end

local function StatusAnnoucementsDescribe(special_data, context)
    if not special_data.time_to_respawn then
        return
    end

    local description = nil

    description = special_data.time_to_respawn

    return {
        description = description,
        append = true
    }
end

return {
	Describe = Describe,
    GetRespawnTime = GetRespawnTime,
    RemoteDescribe = RemoteDescribe,
    StatusAnnoucementsDescribe = StatusAnnoucementsDescribe
}