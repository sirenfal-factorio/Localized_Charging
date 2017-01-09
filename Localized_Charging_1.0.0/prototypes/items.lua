require('volt_util')

data:extend({
	{
		type = "item",
		name = "localized-charging-pole",
		localised_name = {'entity-name.localized-charging-pole'},
		icon = "__Localized_Charging__/graphics/icons/localized-charging-pole.png",
		flags = {"goes-to-quickbar"},
		subgroup = "energy-pipe-distribution",
		order = "a[energy]-b[localized-charging-pole]",
		place_result = "localized-charging-pole",
		stack_size = 10
	},
	clone_existing_data(data.raw['item-with-entity-data']['diesel-locomotive'], {
		name = "electric-locomotive",
		localised_name={'vehicles.electric-locomotive'},
		icon = "__Localized_Charging__/graphics/icons/electric-locomotive.png",
		order = "a[train-system]-f[electric-locomotive]",
		place_result = "electric-locomotive",
	}),
})