if mods["Clowns-Nuclear"] and mods["Clowns-AngelBob-Nuclear"] then
    if settings.startup["tweak-nuclear"].value then
        -- remove emissions multiplier on nuclear fuel
        data.raw.item["nuclear-fuel"].fuel_emissions_multiplier = 1.0

        -- remove bob's thorium-plutonium fuel cells
        bobmods.lib.tech.remove_recipe_unlock("thorium-fuel-reprocessing", "thorium-plutonium-fuel-cell")
    end

    if settings.startup["buff-uranium-processing"].value then
        -- 2/3 cost to 1/2 cost
        bobmods.lib.recipe.set_ingredient("clowns-centrifuging-20%-hexafluoride", {"solid-uranium-hexafluoride", 36})
        data.raw.recipe["clowns-centrifuging-20%-hexafluoride"].results[2]["amount"] = 2
    end
end