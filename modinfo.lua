local function zh_en(zh, en)  -- Other languages don't work
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

    if chinese_languages[locale] ~= nil then
        lang = chinese_languages[locale]
    else
        lang = en
    end

    return lang == "zh" and zh or en
end

name = zh_en("Insight 事件倒计时功能加强","Enhanced countdown feature for Insight")
author = "冰冰羊"
description = [[

为Insight支持岛屿冒险模组中的：虎鲨、火山、浮船骑士、海妖 的倒计时宣告
为Above the Clouds模组添加
蝙蝠、不老泉、蒙面猪人、友善的大鹏、大灾变、大灾变期间的蝙蝠/远古先驱 倒计时显示，同时支持宣告
]]
version = "1.4.3"
dst_compatible = true
forge_compatible = false
gorge_compatible = false
dont_starve_compatible = false
client_only_mod = false
server_only_mod = false
all_clients_require_mod = true
--icon_atlas = "modicon.xml"
--icon = "modicon.tex"
forumthread = ""
api_version_dst = 10
priority = -100001
server_filter_tags = {
    "Insight BOSS倒计时功能加强 v"..version,
    "Enhanced countdown feature for Insight v"..version
}
mod_dependencies = {
    { workshop = "workshop-2189004162" }, -- Insight
}
configuration_options  =
{
    {
        name = "lang",
        label = zh_en("语言", "Language"),
        hover = zh_en("选择你想要使用的语言", "Select the language you want to use"),
        options =
        {
            {description = "English(英语)", data = "en", hover = ""},
            {description = "中文(Chinese)", data = "zh", hover = ""},
            {description = zh_en("自动", "Auto"), data = "auto", hover = zh_en("根据游戏语言自动设置", "Automatically set according to the game language")},
        },
        default = "auto",
    },
}