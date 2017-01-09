data:extend({
	{
		type = "technology",
		name = "voltage-electric-trains",
		icon = "__Localized_Charging__/graphics/technology/electric-trains.png",
		icon_size = 128,
		effects = {
			{
				type = "unlock-recipe",
				recipe = "electric-locomotive",
			},
		},
		prerequisites = {"railway", "effectivity-module"},
		unit = {
			count = 200,
			ingredients = {
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
			},
			time = 45,
		},
		order = "c-g-d",
	},
	{
		type = "technology",
		name = "voltage-wireless-energy-distribution",
		icon = "__base__/graphics/technology/electric-energy-distribution.png",
		effects = {
			{
				type = "unlock-recipe",
				recipe = "localized-charging-pole",
			}
		},
		prerequisites = {"electric-energy-distribution-2"},
		unit = {
			count = 200,
			ingredients = {
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1}
			},
			time = 45
		},
		order = "c-e-c",
	},
})
