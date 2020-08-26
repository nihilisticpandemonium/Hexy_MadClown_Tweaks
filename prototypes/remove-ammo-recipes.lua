if settings.startup["remove-clowns-alt-ammo"].value then
    bobmods.lib.recipe.enabled("copper-nickel-firearm-magazine", false)
    bobmods.lib.recipe.enabled("nickel-piercing-rounds-magazine", false)
end