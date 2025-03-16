extends Node

var buyables: Dictionary = {
	"Castle": {
		"path": "res://scenes/plots/castle_plot.tscn",
		"available": true,
		"cost": 0,
		"icon": "res://art/plot_icons/castle.png",
		"description": "Your first purchase!\nTaxes Citizens to generate a modest amount of gold.\nClick it to generate gold faster!"
	},
	"Lake": {
		"path": "res://scenes/plots/lake_plot.tscn",
		"available": false,
		"cost": 25,
		"icon": "res://art/plot_icons/lake.png",
		"description": "Provides water to nearby areas"
	},
	"Village": {
		"path": "res://scenes/plots/village_plot.tscn",
		"available": false,
		"cost": 50,
		"icon": "res://art/plot_icons/village.png",
		"description": "Provides homes for 10 new citizens"
	},
	"Town": {
		"path": "res://scenes/plots/town_plot.tscn",
		"available": false,
		"cost": 500,
		"icon": "res://art/plot_icons/town.png",
		"description": "Provides homes for 50 new citizens"
	},
	"Store": {
		"path": "res://scenes/plots/store_plot.tscn",
		"available": false,
		"cost": 400,
		"icon": "res://art/plot_icons/store.png",
		"description": "Sells food to nearby villages"
	},
	"Small Farm": {
		"path": "res://scenes/plots/farm_plot.tscn",
		"available": false,
		"cost": 500,
		"icon": "res://art/plot_icons/farm.png",
		"description": "Creates food for your citizens\nNeeds water to grow crops"
	}
}
