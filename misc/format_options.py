# used to print all the options in a markdown list to put on the mod portal

option_names = {
    "remove-particle-accelerators": "Remove particle accelerators",
    "remove-research-facilities": "Remove research facilities",
    "remove-clowns-alt-ammo": "Remove alternate red/yellow ammo recipes",
    "tweak-nuclear": "Tweak nuclear",
    "buff-uranium-processing": "Buff uranium hexafluoride centrifuging",
    "pure-sorting-crafting-time-fix": "Fix pure sorting recipe crafting times",
    "crystal-acid-fix": "MadClown's crystals require acid",
    "buff-sluicing": "Buff sand/alluvium sluicing",
    "remove-magnesium-desalination": "Remove desalination for magnesium recipes",
    "balance-alt-science": "Rebalance MadClown's science pack recipes"
}

option_descriptions = {
    "remove-particle-accelerators": "Remove particle accelerators and the free science pack from power recipes.",
    "remove-research-facilities": "Remove research facilities and the science packs from fluids recipes.",
    "remove-clowns-alt-ammo": "Remove the alternate recipes MadClown's adds for yellow ammo and red ammo.",
    "tweak-nuclear": "Disable thorium-plutionium fuel cells, as well as remove the polluiton modifier that Bob's mods add to normal nuclear fuel.",
    "buff-uranium-processing": "Make it so that hexafluoride centrifuging uses closer to 1/2 the uranium ore used for normal uranium ore centrifuging rather than 2/3 the uranium ore used.",
    "pure-sorting-crafting-time-fix": "Make MadClown's pure ore sorting recipes have 1/1.5 second crafting times instead of 0.5 second crafting times.",
    "crystal-acid-fix": "Make it so making MadClown's crystals actually requires the respective acid from the chunk stage rather than requiring no acid.",
    "buff-sluicing": "Make sand sluicing have 2.5x the yield, and alluvium sluicing have 5x the yield these recipes normally do to make them more appealing.",
    "remove-magnesium-desalination": "Remove the magnesium from salt water desalination recipes, as they make obtaining magnesium too easy.",
    "balance-alt-science": "More expensive science pack recipes have double the yield, and less expensive science pack recipes have less yield. Make the automation science pack II recipe require less materials. Make the logistic science pack II recipe require more chrome to compensate for the decreased alloy requirement of the default recipe. Switch cobalt plate and osmium plate in the production science pack III and high tech science pack III recipes."
}

option_ids = [
    "remove-particle-accelerators",
    "remove-research-facilities",
    "remove-clowns-alt-ammo",
    "tweak-nuclear",
    "buff-uranium-processing",
    "pure-sorting-crafting-time-fix",
    "crystal-acid-fix",
    "buff-sluicing",
    "remove-magnesium-desalination",
    "balance-alt-science"
]

def print_options():
    for key in option_ids:
        print(f'- {option_names[key]}: {option_descriptions[key]}')

print_options()