require('volt_util')


data:extend({
	{
		type = "equipment-grid",
		name = "voltage-electric-locomotive",
		width = 10,
		height = 10,
		equipment_categories = {"armor"},
	},
	clone_existing_data(data.raw.locomotive['diesel-locomotive'], {
		name='electric-locomotive',
		localised_name={'vehicles.electric-locomotive'},
		icon = "__Localized_Charging__/graphics/icons/electric-locomotive.png",
		minable = {mining_time = 1, result = "electric-locomotive"},
		weight = 1750,
		max_speed = 1.5,
		max_power = "2MW",
		reversing_power_modifier = 1.0,
		braking_force = 30,
		order="electric-locomotive",
		equipment_grid = "voltage-electric-locomotive",
		equipment_categories = {"armor"},
		energy_source =
		{
			type = "burner",
			effectivity = 1,
			fuel_inventory_size = 0,
		},
		front_light = {
			__partial__ = true,
			{
				picture =
				{
					scale = 4.5,
				},
				size = 4.5,
				intensity = 0.75
			},
			{
				picture =
				{
					scale = 4.5,
				},
				size = 4.5,
				intensity = 0.75
			}
		},
		working_sound = {
			sound = {
				filename = "__base__/sound/electric-furnace.ogg",
				volume = 0.4,
			},
			match_speed_to_activity = true,
		},
	}),
})