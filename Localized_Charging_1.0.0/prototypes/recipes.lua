data:extend({
	{
		type = "recipe",
		name = "localized-charging-pole-1",
		localised_name = {'entity-name.localized-charging-pole-1'},
		enabled = false,
		ingredients = {
			{"advanced-circuit", 20},
			{"electronic-circuit", 40},
			{"iron-plate", 90},
			{"steel-plate", 15},
			{"wood", 5},
			{"battery", 15},
		},
		result = "localized-charging-pole-1",
	},

	{
		type = "recipe",
		name = "localized-charging-pole-2",
		localised_name = {'entity-name.localized-charging-pole-2'},
		enabled = false,
		ingredients = {
			{"advanced-circuit", 5},
			{"electronic-circuit", 20},
			{"iron-plate", 10},
			{"steel-plate", 5},
			{"battery", 5},
			{"localized-charging-pole-1", 1},
		},
		result = "localized-charging-pole-2",
	},

	{
		type = "recipe",
		name = "localized-charging-pole-3",
		localised_name = {'entity-name.localized-charging-pole-3'},
		enabled = false,
		ingredients = {
			{"advanced-circuit", 10},
			{"electronic-circuit", 30},
			{"iron-plate", 20},
			{"steel-plate", 5},
			{"battery", 10},
			{"localized-charging-pole-2", 1},
		},
		result = "localized-charging-pole-3",
	},

	{
		type = "recipe",
		name = "localized-charging-pole-4",
		localised_name = {'entity-name.localized-charging-pole-4'},
		enabled = false,
		ingredients = {
			{"advanced-circuit", 15},
			{"electronic-circuit", 35},
			{"iron-plate", 30},
			{"steel-plate", 5},
			{"battery", 20},
			{"localized-charging-pole-3", 1},
		},
		result = "localized-charging-pole-4",
	},
	{
		type = "recipe",
		name = "electric-locomotive",
		localised_name = {'vehicles.electric-locomotive'},
		enabled = false,
		ingredients = {
			{"electric-engine-unit", 50},
			{"electronic-circuit", 50},
			{"steel-plate", 75},
			{"effectivity-module", 5},
		},
		result = "electric-locomotive"
	},
})
