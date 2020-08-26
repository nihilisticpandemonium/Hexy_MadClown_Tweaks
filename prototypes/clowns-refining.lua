if mods["Clowns-Extended-Minerals"] and settings.startup["remove-magnesium-desalination"].value then
    bobmods.lib.tech.remove_recipe_unlock("water-treatment-4", "intermediate-salination")
    if not mods['extendedangels'] then
        data.raw.technology["water-treatment-5"].enabled = false
    else
        -- does nothing, will do something when extended angels bug gets fixed
        bobmods.lib.tech.remove_recipe_unlock('water-treatment-5', 'advanced-desalination')
    end
end

if settings.startup["buff-sluicing"].value then
    local function multiply_result_probabilities(recipe_name, multiplier)
        recipe = data.raw.recipe[recipe_name]
        if not recipe then
            log("multiply_result_probabilities: recipe '"..recipe_name.."' does not exist!")
        else
            for _, result in pairs(recipe.results) do
                if result.probability then
                    result.probability = result.probability * multiplier
                end
            end
        end
    end

    multiply_result_probabilities("sand-sluicing", 2.5)
    if mods["Clowns-Extended-Minerals"] then
        multiply_result_probabilities("clowns-resource1-sluicing", 5)
        multiply_result_probabilities("clowns-resource1-sluicing-advanced", 5)
    end
end