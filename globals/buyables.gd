extends Node

var buyables: Dictionary = {
	"Castle": {
		"path": "res://scenes/plots/castle_plot.tscn",
		"available": true,
		"cost": 0,
		"icon": "res://art/plot_icons/castle.png",
		"description": "Your first purchase! Generates a modest amount of gold.\nClick it to generate gold faster!"
	},
	"Lake": {
		"path": "res://scenes/plots/lake_plot.tscn",
		"available": false,
		"cost": 25,
		"icon": "res://art/plot_icons/castle.png",
		"description": "Provides water to nearby areas"
	}
}
