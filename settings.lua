local setting_order_string = "aa"

local function inc_order_string()
    if setting_order_string:sub(2,2) == "z" then
        setting_order_string = string.char(setting_order_string:byte(1) + 1).."a"
    else
        setting_order_string = setting_order_string:sub(1,1)..string.char(setting_order_string:byte(2) + 1)
    end
end

local function add_bool_setting(setting_name, default)
    data:extend({
        {
            type = "bool-setting",
            name = setting_name,
            setting_type = "startup",
            order = setting_order_string,
            default_value = default,
        },
    })
    inc_order_string()
end

add_bool_setting("remove-particle-accelerators", false)
add_bool_setting("remove-research-facilities", false)
add_bool_setting("remove-clowns-alt-ammo", false)

add_bool_setting("tweak-nuclear", false)
add_bool_setting("buff-uranium-processing", false)
add_bool_setting("pure-sorting-crafting-time-fix", false)
add_bool_setting("buff-sluicing", false)
add_bool_setting("remove-magnesium-desalination", false)
add_bool_setting("balance-alt-science", false)