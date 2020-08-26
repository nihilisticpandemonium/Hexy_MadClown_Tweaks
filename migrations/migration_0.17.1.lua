function disable_techs(force, tech_list)
    for _, tech_name in pairs(tech_list) do
        if force.technologies[tech_name] then
            force.technologies[tech_name].researched = false
            force.technologies[tech_name].enabled = false
        else
            log("disable_techs: technology '"..tech_name.."' does not exist.")
        end
    end
end

function disable_techs_if_option(force, option, tech_list)
    if not settings.startup[option] then
        log("disable_techs_if_option: option '"..option.."' does not exist.")
    elseif settings.startup[option].value then
        for _, tech_name in pairs(tech_list) do
            if force.technologies[tech_name] then
                force.technologies[tech_name].researched = false
                force.technologies[tech_name].enabled = false
            else
                log("disable_techs_if_option for option '"..option.."': technology '"..tech_name.."' does not exist.")
            end
        end
    end
end

for _, force in pairs(game.forces) do
    disable_techs_if_option(force, "remove-magnesium-desalination", {
        "water-treatment-5"
    })

    disable_techs_if_option(force, "remove-particle-accelerators", {
        "particle-accelerator-1",
        "particle-accelerator-2",
    })

    disable_techs_if_option(force, "remove-research-facilities", {
        "facility-1",
        "facility-2",
        "facility-3",
    })
end