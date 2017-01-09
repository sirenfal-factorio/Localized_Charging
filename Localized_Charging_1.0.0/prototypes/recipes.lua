data:extend({
	{
		type = "recipe",
		name = "localized-charging-pole",
		localised_name = {'entity-name.localized-charging-pole'},
		enabled = false,
		ingredients = {
			{"advanced-circuit", 50},
			{"electronic-circuit", 125},
			{"iron-plate", 150},
			{"steel-plate", 30},
			{"wood", 5},
			{"battery", 50},
		},
		result = "localized-charging-pole",
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