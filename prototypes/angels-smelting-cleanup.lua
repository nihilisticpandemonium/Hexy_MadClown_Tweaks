local function add_plate_casting(metal)
    bobmods.lib.tech.add_recipe_unlock("angels-"..metal.."-smelting-1", "molten-"..metal.."-smelting")
    bobmods.lib.tech.add_recipe_unlock("angels-"..metal.."-smelting-1", "angels-plate-"..metal)
end

if settings.startup["angels-casting-cleanup"].value then
    if mods["Clowns-Extended-Minerals"] then
        bobmods.lib.tech.remove_recipe_unlock("advanced-magnesium-smelting", "molten-magnesium-smelting")
        bobmods.lib.tech.remove_recipe_unlock("advanced-magnesium-smelting", "clowns-plate-magnesium")
    end

    if mods["Clowns-Science"] then
        add_plate_casting("manganese")
        add_plate_casting("chrome")
        add_plate_casting("cobalt")
    elseif mods["Clowns-Extended-Minerals"] then
        bobmods.lib.tech.remove_recipe_unlock("advanced-osmium-smelting", "casting-powder-osmium")
        bobmods.lib.tech.remove_recipe_unlock("advanced-osmium-smelting", "clowns-plate-osmium")
    end
end