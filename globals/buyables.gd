extends Node

func is_unlocked(item_name: String) -> bool:
	return buyables[item_name]["available"]

var buyables: Dictionary = {
	"Castle": {
		"path": "res://scenes/plots/castle_plot.tscn",
		"available": true,
		"cost": 0,
		"food_cost": 0,
		"icon": "res://art/plot_icons/castle.png",
		"description": "Your first purchase!\nTaxes Citizens to generate a modest amount of gold.\nClick it to generate gold faster!"
	},
	"Lake": {
		"path": "res://scenes/plots/lake_plot.tscn",
		"available": false,
		"cost": 25,
		"food_cost": 0,
		"icon": "res://art/plot_icons/lake.png",
		"description": "Provides water to nearby areas"
	},
	"Iron Mine": {
		"path": "res://scenes/plots/iron_plot.tscn",
		"available": false,
		"cost": 1000,
		"food_cost": 25,
		"icon": "res://art/plot_icons/iron_mine.png",
		"description": "Produces the iron used to upgrade your kingdom!"
	},
	"Village": {
		"path": "res://scenes/plots/village_plot.tscn",
		"available": false,
		"cost": 50,
		"food_cost": 0,
		"icon": "res://art/plot_icons/village.png",
		"description": "Provides homes for 10 new citizens\nCitizens will buy food from nearby stores!"
	},
	"Town": {
		"path": "res://scenes/plots/town_plot.tscn",
		"available": false,
		"cost": 250,
		"food_cost": 50,
		"icon": "res://art/plot_icons/town.png",
		"description": "Provides homes for 50 new citizens\nEven more citizens to spend money!"
	},
	"Store": {
		"path": "res://scenes/plots/store_plot.tscn",
		"available": false,
		"cost": 400,
		"food_cost": 0,
		"icon": "res://art/plot_icons/store.png",
		"description": "Sells food to nearby villages"
	},
	"Small Farm": {
		"path": "res://scenes/plots/farm_plot.tscn",
		"available": false,
		"cost": 500,
		"food_cost": 0,
		"icon": "res://art/plot_icons/farm.png",
		"description": "Creates food for your citizens\nNeeds water to grow crops"
	}
}

var upgrades: Array = [
	{
		"name": "Castle Speed 1",
		"available": true,
		"description": "Your castles will produce gold slightly faster",
		"cost": 2000,
		"eval": "increase_castle_speed(1)",
		"next_unlock": "Castle Speed 2",
	},
		{
		"name": "Castle Speed 2",
		"available": false,
		"description": "Your castles will produce gold much faster",
		"cost": 10000,
		"eval": "increase_castle_speed(2)",
		"next_unlock": "",
	},
]
