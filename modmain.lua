GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

_G = GLOBAL

Assets = {
    Asset("ATLAS", "images/lifeplant.xml"), -- 不老泉
    Asset("IMAGE", "images/lifeplant.tex"),

    Asset("ATLAS", "images/pig_bandit.xml"), -- 蒙面猪人
    Asset("IMAGE", "images/pig_bandit.tex"),
}

-------------------------------------------------------------------------------------------------------------------------------------------------

-- 语言检测
local lang = GetModConfigData("lang") or "auto"
if lang == "auto" then
    lang = _G.LanguageTranslator.defaultlang
end

local chinese_languages =
{
    zh = "zh", -- Chinese for Steam
    zhr = "zh", -- Chinese for WeGame
    ch = "zh", -- Chinese mod
    chs = "zh", -- Chinese mod
    sc = "zh", -- simple Chinese
    zht = "zh", -- traditional Chinese for Steam
	tc = "zh", -- traditional Chinese
	cht = "zh", -- Chinese mod
}

-- 检测某个模组是否加载
local function Ismodloaded(name)
    if _G.KnownModIndex:IsModEnabledAny(name) then
        return true
    end
end

if chinese_languages[lang] ~= nil then
    lang = chinese_languages[lang]
else
    lang = "en"
end

modimport("language/"..lang..".lua")

local function AddDescriptors()
    if not _G.rawget(_G, "Insight") then return end
    -- 原版
        _G.Insight.descriptors.flotsamgenerator = _G.require("descriptors/flotsamgenerator") -- Player页面 下一个瓶中信刷新倒计时

    -- 岛屿冒险-海难
        _G.Insight.descriptors.volcanomanager = _G.require("descriptors/islandadventures_volcanomanager") -- 火山爆发倒计时
        _G.Insight.descriptors.tigersharker = _G.require("descriptors/islandadventures_tigersharker") -- 虎鲨倒计时支持宣告
        _G.Insight.descriptors.chessnavy = _G.require("descriptors/islandadventures_chessnavy") -- 浮船骑士倒计时支持宣告
        _G.Insight.descriptors.krakener = _G.require("descriptors/islandadventures_krakener") -- 海妖倒计时支持宣告

    -- if Ismodloaded("workshop-3322803908") then -- 猪镇 by.亚丹
        _G.Insight.descriptors.aporkalypse = _G.require("descriptors/porkland_aporkalypse") -- 大灾变倒计时
        _G.Insight.descriptors.batted = _G.require("descriptors/porkland_batted") -- 蝙蝠袭击倒计时
        _G.Insight.descriptors.banditmanager = _G.require("descriptors/porkland_banditmanager") -- 蒙面猪人倒计时
        _G.Insight.descriptors.rocmanager = _G.require("descriptors/porkland_rocmanager") -- 大鸟倒计时
    -- end
end

AddSimPostInit(AddDescriptors) -- _G.Insight.descriptors may not exist yet, but it will exist at AddSimPostInit.

-------------------------------------------------------------------------------------------------------------------------------------------------

-- if Ismodloaded("workshop-3322803908") then -- 猪镇 by.亚丹
    if not _G.rawget(_G, "Insight") then return end

    AddPrefabPostInit("pugalisk_fountain", function(inst)
        _G.Insight.prefab_descriptors.pugalisk_fountain = _G.require("prefab_descriptors/porkland_pugalisk_fountain") -- 不老泉

        if _G.TheNet:GetIsServer() then
            _G.TheWorld.shard.components.shard_insight:RegisterWorldDataFetcher("pugalisk_fountain", function()
                return _G.Insight.prefab_descriptors.pugalisk_fountain and _G.Insight.prefab_descriptors.pugalisk_fountain.GetRespawnTime and _G.Insight.prefab_descriptors.pugalisk_fountain.GetRespawnTime(inst) or nil
            end)
            _G.TheWorld.shard.components.shard_insight:RegisterDescriptor("pugalisk_fountain", _G.Insight.prefab_descriptors.pugalisk_fountain and _G.Insight.prefab_descriptors.pugalisk_fountain.RemoteDescribe or nil )
        end
    end)
-- end