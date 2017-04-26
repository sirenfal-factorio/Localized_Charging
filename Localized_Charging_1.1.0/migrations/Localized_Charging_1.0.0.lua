for i, force in pairs(game.forces) do
    force.reset_recipes()
    force.reset_technologies()
    if force.technologies["voltage-wireless-energy-distribution"].researched then
        force.recipes["localized-charging-pole-1"].enabled = true
        force.recipes["localized-charging-pole-2"].enabled = true
        force.recipes["localized-charging-pole-3"].enabled = true
        force.recipes["localized-charging-pole-4"].enabled = true
    end
end
