if mods["Clowns-Science"] then
    if settings.startup["remove-particle-accelerators"].value then
        data.raw.technology["particle-accelerator-1"].enabled = false
        data.raw.technology["particle-accelerator-2"].enabled = false
    end

    if settings.startup["remove-research-facilities"].value then
        data.raw.technology["facility-1"].enabled = false
        data.raw.technology["facility-2"].enabled = false
        data.raw.technology["facility-3"].enabled = false
        bobmods.lib.tech.remove_recipe_unlock("military-science-pack", "facility-military-science-pack")
        bobmods.lib.tech.remove_recipe_unlock("chemical-science-pack", "facility-science-pack-3")
        bobmods.lib.tech.remove_recipe_unlock("production-science-pack", "facility-production-science-pack")
        bobmods.lib.tech.remove_recipe_unlock("advanced-logistic-science-pack", "facility-logistic-science-pack")
        bobmods.lib.tech.remove_recipe_unlock("utility-science-pack", "facility-high-tech-science-pack")
    end

    if settings.startup["balance-alt-science"].value then
        local function change_science_result_amount(recipe_name, amount)
            recipe = data.raw.recipe[recipe_name]
            if not recipe then
                log("change_science_result_amount: recipe '"..recipe_name.."' does not exist!")
            elseif recipe.result then
                recipe.results = {
                    bobmods.lib.item.item({recipe.result, amount})
                }
            else
                recipe.results[1]["amount"] = amount
            end
        end


        -- automation science requires recipe changes for good balance
        bobmods.lib.recipe.set_ingredient("alt1-science-pack-1", {"wooden-chest", 1})
        bobmods.lib.recipe.set_ingredient("alt1-science-pack-1", {"stone-pipe", 2})
        -- increase automation science amount
        change_science_result_amount("alt1-science-pack-1", 2)
        change_science_result_amount("alt2-science-pack-1", 2)

        -- increase logistic science amount
        change_science_result_amount("alt1-science-pack-2", 2)

        data.raw.recipe["alt1-science-pack-3"].energy_required = 14
        data.raw.recipe["alt2-science-pack-3"].energy_required = 14

        -- military II is not worth 3 science packs, military III is worth 4
        change_science_result_amount("alt1-military-science-pack", 2)
        data.raw.recipe["alt1-military-science-pack"].energy_required = 10
        change_science_result_amount("alt2-military-science-pack", 4)

        -- switch osmium and cobalt plate in prod science III/utility science III
        bobmods.lib.recipe.replace_ingredient("alt2-production-science-pack", "clowns-plate-osmium", "cobalt-plate")
        bobmods.lib.recipe.replace_ingredient("alt2-high-tech-science-pack", "cobalt-plate", "clowns-plate-osmium")
        -- prod II is not worth 3 science packs
        data.raw.recipe["alt1-production-science-pack"].energy_required = 21
        change_science_result_amount("alt1-production-science-pack", 2)
        data.raw.recipe["alt2-production-science-pack"].energy_required = 21

        -- logistic science pack requires too few resources to justify amount returned
        bobmods.lib.recipe.set_ingredient("alt1-logistic-science-pack", {"angels-plate-chrome", 4})
        data.raw.recipe["alt1-logistic-science-pack"].energy_required = 21

        data.raw.recipe["alt1-high-tech-science-pack"].energy_required = 28
        change_science_result_amount("alt1-high-tech-science-pack", 2)
        data.raw.recipe["alt2-high-tech-science-pack"].energy_required = 28
        change_science_result_amount("alt2-high-tech-science-pack", 2)
    end
end