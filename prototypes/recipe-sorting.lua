-- if a recipe doesn't have an order/subgroup defined, it either must be a part
-- of the only result of the recipe or a part of the main product of the recipe.
-- in either case, we want to explicitly set the order and subgroup of the
-- recipe to make life easier.
local function resolve_order_subgroup(recipe)
    local has_main_product, item_type
    if recipe.main_product then
        has_main_product = true
        item_type = bobmods.lib.item.get_type(recipe.main_product)
    else
        has_main_product = false
        item_type = bobmods.lib.item.get_type(recipe.name)
    end

    if not recipe.order then
        if has_main_product then
            recipe.order = data.raw[item_type][recipe.main_product].order
        else
            recipe.order = data.raw[item_type][recipe.name].order
        end
    end

    if not recipe.subgroup then
        if has_main_product then
            recipe.subgroup = data.raw[item_type][recipe.main_product].subgroup
        else
            recipe.subgroup = data.raw[item_type][recipe.name].subgroup
        end
    end
end

local function sort_between(recipe_name, before_name, after_name)
    local recipe, before, after
    if recipe_name then
        recipe = data.raw.recipe[recipe_name]
        if not recipe then
            log("\n!!!!!!! sort_between recipe: "..recipe_name.." doesn't exist !!!!!!!!\n")
            return
        end
    end
    if before_name then
        before = data.raw.recipe[before_name]
        if not before then
            log("\n!!!!!!! sort_between before: "..before_name.." doesn't exist !!!!!!!!\n")
            return
        end
        resolve_order_subgroup(before)
    end
    if after_name then
        after = data.raw.recipe[after_name]
        if not after then
            log("\n!!!!!!! sort_between after:  "..after_name.." doesn't exist !!!!!!!!\n")
            return
        end
        resolve_order_subgroup(after)
    end

    -- missing first arg, this is invalid
    if not recipe then
        log("\n!!!!!!! sort_between called without recipe !!!!!!!!\n")
    -- missing both args, this is invalid
    elseif not after and not before then
        log("\n!!!!!!! sort_between called on "..recipe.name.." with no before or after !!!!!!!!\n")
    -- just before
    elseif not after then
        recipe.subgroup = before.subgroup
        local last_letter_ascii = before.order:byte(-1)
        -- already at last ascii printable character? add a character
        if last_letter_ascii == 126 then
            recipe.order = before.." "
        else
            recipe.order = before.order:sub(1, -2)..string.char(last_letter_ascii + 1)
        end
    -- just after
    elseif not before then
        recipe.subgroup = after.subgroup
        local last_letter_ascii = after.order:byte(-1)
        -- already at first ascii printable character? lose a character
        if last_letter_ascii == 33 then
            recipe.order = after.order:sub(1, -3).."~"
        else
            recipe.order = after.order:sub(1, -2)..string.char(last_letter_ascii - 1)
        end
    -- have both, but subgroups don't match, this is invalid
    elseif before.subgroup ~= after.subgroup then
        log("\n!!!!!!! sort_between called on "..recipe.name..", "..before.name..", "..after.name.." but before and after are in different subgroups !!!!!!!\n")
    -- have both
    else
        recipe.subgroup = before.subgroup
        local last_letter_ascii = before.order:byte(-1)
        -- order strings are same or 1 char apart, so no guarantee of sort between
        if before.order:len() == after.order:len() and last_letter_ascii + 1 >= after.order:byte(-1) then
            log("\n!!!!!!! sort_between called on "..recipe.name..", "..before.name..", "..after.name.." order strings are too close to guarantee between, defaulting to after's order string !!!!!!!\n")
            recipe.order = after.order
        -- otherwise, we are good
        else
            -- already at last ascii printable character? add a character
            if last_letter_ascii == 126 then
                recipe.order = before.." "
            else
                recipe.order = before.order:sub(1, -2)..string.char(last_letter_ascii + 1)
            end
        end
    end
end

local function sort_after(recipe_name, before_name)
    sort_between(recipe_name, before_name, nil)
end

local function sort_before(recipe_name, after_name)
    sort_between(recipe_name, nil, after_name)
end

local function sort_chain(array)
    for i = 2, #array do
        sort_after(array[i], array[i-1])
    end
end

local function sort_chain_reverse(array)
    for i = #array, 2, -1 do
        sort_before(array[i-1], array[i])
    end
end

local function set_subgroup(subgroup, array)
    local first_recipe = data.raw.recipe[array[1]]
    if first_recipe then
        resolve_order_subgroup(first_recipe)
        first_recipe.subgroup = subgroup
        first_recipe.order = "a"
        if #array > 1 then
            sort_chain(array)
        end
    else
        log("\n!!!!!!! set_subgroup first recipe: "..array[1].." doesn't exist !!!!!!!!\n")
    end
end

local function move_subgroup(subgroup_name, new_group, new_order)
    subgroup = data.raw["item-subgroup"][subgroup_name]
    if subgroup then
        if data.raw["item-group"][new_group] then
            subgroup.group = new_group
            subgroup.order = new_order
        else
            log("\n!!!!!!! move_subgroup new_group: "..new_group.." doesn't exist !!!!!!!!\n")
        end
    else
        log("\n!!!!!!! move_subgroup subgroup: "..subgroup_name.." doesn't exist !!!!!!!!\n")
    end
end

if settings.startup["remove-bobs-fluids-materials"].value then
    -- madclown's processing moves gems to bob's resources: we undo this here
    for _, subgroup in pairs(data.raw["item-subgroup"]) do
        if subgroup.group == "bob-resource-products" then
            subgroup.group = "bob-gems"
        end
    end
end

if settings.startup["add-nuclear-tab"].value then
    sort_chain{
        "centrifuge",
        "centrifuge-mk2",
        "centrifuge-mk3"
    }

    move_subgroup("clowns-uranium-centrifuging", "nuclear", "e-a")
    sort_chain_reverse{
        "uranium-processing",
        "thorium-processing",
        "depleted-uranium-reprocessing"
    }
    if data.raw.recipe["advanced-uranium-processing"] then
        sort_between("advanced-uranium-processing", "uranium-processing", "thorium-processing")
    end

    sort_chain{
        "uranium-fuel-cell",
        "mixed-oxide",
        "nuclear-fuel-reprocessing",
        "advanced-nuclear-fuel-reprocessing",
    }

    sort_chain{
        "thorium-fuel-cell",
        "thorium-mixed-oxide",
        "thorium-nuclear-fuel-reprocessing",
        "advanced-thorium-nuclear-fuel-reprocessing",
        "advanced-thorium-nuclear-fuel-reprocessing|b",
        "bobingabout-enrichment-process"
    }

    sort_before("nuclear-fuel", "hypernuclear-fuel")
    move_subgroup("clowns-nuclear-fuels", "nuclear", "h-a")
end

if settings.startup["reorganize-military"].value then
    sort_chain{
        "atomic-bomb",
        "plutonium-atomic-bomb",
        "thermonuclear-bomb"
    }

    sort_chain{
        "firearm-magazine",
        "copper-nickel-firearm-magazine",
        "piercing-rounds-magazine",
        "nickel-piercing-rounds-magazine"
    }

    if mods["bobwarfare"] then
        sort_chain{
            "poison-artillery-shell",
            "artillery-shell-nuclear",
            "artillery-shell-thermonuclear",
        }
        sort_after("neurotoxin-capsule", "fire-capsule")
    else
        sort_chain{
            "artillery-shell",
            "artillery-shell-nuclear",
            "artillery-shell-thermonuclear",
        }
        sort_after("neurotoxin-capsule", "slowdown-capsule")
    end
end

if settings.startup["merge-intermediates"].value then
    sort_chain_reverse{
        "heat-shield-tile",
        "rocket-control-unit",
        "low-density-structure",
        "rocket-fuel",
        "satellite",
        "assembly-robot",
        "drydock-assembly"
    }

    -- improved spacex ftl research mod support
    sort_after("ftl-research-satellite", "ftl-drive")

    move_subgroup("spacex", "intermediate-products", "e-c-a")
end