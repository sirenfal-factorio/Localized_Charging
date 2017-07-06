require('constants')

-- in megajoules per second
local charging_output = 40

data:extend({
	{
		type = "explosion",
		name = "charging-charge",
		flags = {"not-on-map", "placeable-off-grid"},
		animation_speed = 1,
		rotate = true,
		beam = true,
		animations =
		{
		  {
			filename = "__Localized_Charging__/graphics/entity/projectile/induction-charge-beam.png",
			priority = "extra-high",
			width = 20,
			height = 70,
			frame_count = 6,
		  }
		},
		light = {
			intensity = 0.15,
			size = 14,
			shift = {0, 1.5},
			color = {r = 70 / 255, g = 153 / 255, b = 223 / 255},
		},
		-- smoke = "smoke-fast",
		-- smoke_count = 1,
		-- smoke_slow_down_factor = 1
	},
	{
		type = "electric-energy-interface",
		name = "localized-charging-pole-interface-1",
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		localised_name = {'entity-name.localized-charging-pole-1'},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		flags = {"not-blueprintable", "not-deconstructable", "not-on-map", "placeable-off-grid"},
		max_health = 1, -- At least you made it invulnerable in the script.
		corpse = "medium-remnants",
		collision_mask = {},
		energy_source =
		{
			type = "electric",
			buffer_capacity = (((charging_output / 8) * scan_tick) / 60) .. 'MJ',
			usage_priority = "secondary-input",
			input_flow_limit = ((charging_output / 8) * scan_tick) .. 'MW',
			output_flow_limit = "0W"
		},
		energy_production = "0W",
		energy_usage = "0kW",
		picture =
		{
			filename = "__core__/graphics/empty.png",
			priority = "low",
			width = 1,
			height = 1,
		},
	},
	{
		type = "electric-energy-interface",
		name = "localized-charging-pole-interface-2",
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		localised_name = {'entity-name.localized-charging-pole-2'},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		flags = {"not-blueprintable", "not-deconstructable", "not-on-map", "placeable-off-grid"},
		max_health = 1,
		corpse = "medium-remnants",
		collision_mask = {},
		energy_source =
		{
			type = "electric",
			buffer_capacity = (((charging_output / 4) * scan_tick) / 60) .. 'MJ',
			usage_priority = "secondary-input",
			input_flow_limit = ((charging_output / 4) * scan_tick) .. 'MW',
			output_flow_limit = "0W"
		},
		energy_production = "0W",
		energy_usage = "0kW",
		picture =
		{
			filename = "__core__/graphics/empty.png",
			priority = "low",
			width = 1,
			height = 1,
		},
	},
	{
		type = "electric-energy-interface",
		name = "localized-charging-pole-interface-3",
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		localised_name = {'entity-name.localized-charging-pole-3'},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		flags = {"not-blueprintable", "not-deconstructable", "not-on-map", "placeable-off-grid"},
		max_health = 1,
		corpse = "medium-remnants",
		collision_mask = {},
		energy_source =
		{
			type = "electric",
			buffer_capacity = (((charging_output / 2) * scan_tick) / 60) .. 'MJ',
			usage_priority = "secondary-input",
			input_flow_limit = ((charging_output / 2) * scan_tick) .. 'MW',
			output_flow_limit = "0W"
		},
		energy_production = "0W",
		energy_usage = "0kW",
		picture =
		{
			filename = "__core__/graphics/empty.png",
			priority = "low",
			width = 1,
			height = 1,
		},
	},
	{
		type = "electric-energy-interface",
		name = "localized-charging-pole-interface-4",
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		localised_name = {'entity-name.localized-charging-pole-4'},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		flags = {"not-blueprintable", "not-deconstructable", "not-on-map", "placeable-off-grid"},
		max_health = 1,
		corpse = "medium-remnants",
		collision_mask = {},
		energy_source =
		{
			type = "electric",
			buffer_capacity = ((charging_output * scan_tick) / 60) .. 'MJ',
			usage_priority = "secondary-input",
			input_flow_limit = (charging_output * scan_tick) .. 'MW',
			output_flow_limit = "0W"
		},
		energy_production = "0W",
		energy_usage = "0kW",
		picture =
		{
			filename = "__core__/graphics/empty.png",
			priority = "low",
			width = 1,
			height = 1,
		},
	},
	{
		type = "electric-pole",
		name = 'localized-charging-pole-1',
		localised_name = {'entity-name.localized-charging-pole-1'},
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "localized-charging-pole-1"},
		max_health = 400,
		corpse = "medium-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		selection_box = {{-1, -1}, {1, 1}},
		drawing_box = {{-1, -3}, {1, 0.5}},
		maximum_wire_distance = 30,
		supply_area_distance = 0,
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		pictures =
		{
			filename = '__Localized_Charging__/graphics/entity/localized-charging-pole/powered.png',
			priority = "high",
			width = 168,
			height = 165,
			direction_count = 4,
			shift = {1.6, -1.1}
		},
		connection_points =
		{
			{
				shadow =
				{
					copper = {2.7, 0},
				},
				wire =
				{
					copper = {0, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {2.9, 0.06},
				},
				wire =
				{
					copper = {-0.09375, -3.09375},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.1875},
				}
			}
		},
		radius_visualisation_picture =
		{
			filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
			width = 12,
			height = 12,
			priority = "extra-high-no-scale"
		},
	},
	{
		type = "electric-pole",
		name = 'localized-charging-pole-2',
		localised_name = {'entity-name.localized-charging-pole-2'},
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "localized-charging-pole-2"},
		max_health = 400,
		corpse = "medium-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		selection_box = {{-1, -1}, {1, 1}},
		drawing_box = {{-1, -3}, {1, 0.5}},
		maximum_wire_distance = 30,
		supply_area_distance = 0,
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		pictures =
		{
			filename = '__Localized_Charging__/graphics/entity/localized-charging-pole/powered.png',
			priority = "high",
			width = 168,
			height = 165,
			direction_count = 4,
			shift = {1.6, -1.1}
		},
		connection_points =
		{
			{
				shadow =
				{
					copper = {2.7, 0},
				},
				wire =
				{
					copper = {0, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {2.9, 0.06},
				},
				wire =
				{
					copper = {-0.09375, -3.09375},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.1875},
				}
			}
		},
		radius_visualisation_picture =
		{
			filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
			width = 12,
			height = 12,
			priority = "extra-high-no-scale"
		},
	},
	{
		type = "electric-pole",
		name = 'localized-charging-pole-3',
		localised_name = {'entity-name.localized-charging-pole-3'},
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "localized-charging-pole-3"},
		max_health = 400,
		corpse = "medium-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		selection_box = {{-1, -1}, {1, 1}},
		drawing_box = {{-1, -3}, {1, 0.5}},
		maximum_wire_distance = 30,
		supply_area_distance = 0,
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		pictures =
		{
			filename = '__Localized_Charging__/graphics/entity/localized-charging-pole/powered.png',
			priority = "high",
			width = 168,
			height = 165,
			direction_count = 4,
			shift = {1.6, -1.1}
		},
		connection_points =
		{
			{
				shadow =
				{
					copper = {2.7, 0},
				},
				wire =
				{
					copper = {0, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {2.9, 0.06},
				},
				wire =
				{
					copper = {-0.09375, -3.09375},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.1875},
				}
			}
		},
		radius_visualisation_picture =
		{
			filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
			width = 12,
			height = 12,
			priority = "extra-high-no-scale"
		},
	},
	{
		type = "electric-pole",
		name = 'localized-charging-pole-4',
		localised_name = {'entity-name.localized-charging-pole-4'},
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "localized-charging-pole-4"},
		max_health = 400,
		corpse = "medium-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
		selection_box = {{-1, -1}, {1, 1}},
		drawing_box = {{-1, -3}, {1, 0.5}},
		maximum_wire_distance = 30,
		supply_area_distance = 0,
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		pictures =
		{
			filename = '__Localized_Charging__/graphics/entity/localized-charging-pole/powered.png',
			priority = "high",
			width = 168,
			height = 165,
			direction_count = 4,
			shift = {1.6, -1.1}
		},
		connection_points =
		{
			{
				shadow =
				{
					copper = {2.7, 0},
				},
				wire =
				{
					copper = {0, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.125},
				}
			},
			{
				shadow =
				{
					copper = {2.9, 0.06},
				},
				wire =
				{
					copper = {-0.09375, -3.09375},
				}
			},
			{
				shadow =
				{
					copper = {3.1, 0.2},
				},
				wire =
				{
					copper = {-0.0625, -3.1875},
				}
			}
		},
		radius_visualisation_picture =
		{
			filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
			width = 12,
			height = 12,
			priority = "extra-high-no-scale"
		},
	},
})
