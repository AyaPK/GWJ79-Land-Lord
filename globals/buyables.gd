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
		"description": "Produces the iron used to upgrade your kingdom!\nNearby citizens will come here to work."
	},
	"Gold Mine": {
		"path": "res://scenes/plots/gold_plot.tscn",
		"available": false,
		"cost": 500,
		"food_cost": 0,
		"icon": "res://art/plot_icons/gold_mine.png",
		"description": "Mines gold to spend on more stuff!\nNearby citizens will come here to work."
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
		"cost": 100,
		"food_cost": 0,
		"icon": "res://art/plot_icons/store.png",
		"description": "Sells food to nearby villages"
	},
	"Small Farm": {
		"path": "res://scenes/plots/farm_plot.tscn",
		"available": false,
		"cost": 100,
		"food_cost": 0,
		"icon": "res://art/plot_icons/farm.png",
		"description": "Creates food for your citizens\nNeeds water to grow crops"
	},
	"Large Farm": {
		"path": "res://scenes/plots/large_farm.tscn",
		"available": false,
		"cost": 5000,
		"food_cost": 100,
		"icon": "res://art/plot_icons/large_farm.png",
		"description": "Creates a lot of food for your citizens\nNeeds water to grow crops"
	},
}

var upgrades: Array = [
	{
		"name": "Castle Speed 1",
		"available": true,
		"description": "Your castles will produce gold slightly faster",
		"cost": 50,
		"eval": "increase_castle_speed(2)",
		"next_unlock": "Castle Speed 2",
	},
	{
		"name": "Castle Speed 2",
		"available": false,
		"description": "Your castles will produce gold much faster",
		"cost": 500,
		"eval": "increase_castle_speed(3)",
		"next_unlock": "Castle Speed 3",
	},
	{
		"name": "Castle Speed 3",
		"available": false,
		"description": "Your castles will produce gold at the fastest possible rate",
		"cost": 10000,
		"eval": "increase_castle_speed(5)",
		"next_unlock": "",
	},
	{
		"name": "Castle Money 1",
		"available": true,
		"description": "Your castles will produce more gold per tax",
		"cost": 50,
		"eval": "increase_castle_val(2)",
		"next_unlock": "Castle Money 2",
	},
	{
		"name": "Castle Money 2",
		"available": false,
		"description": "Your castles will produce a lot more gold per tax",
		"cost": 500,
		"eval": "increase_castle_val(3)",
		"next_unlock": "Castle Money 3",
	},
	{
		"name": "Castle Money 3",
		"available": false,
		"description": "Your castles will produce a mountain of gold",
		"cost": 10000,
		"eval": "increase_castle_val(20)",
		"next_unlock": "",
	},
	{
		"name": "Farm Speed 1",
		"available": true,
		"description": "Your farmers will work slightly faster",
		"cost": 500,
		"eval": "increase_farm_speed(2)",
		"next_unlock": "Farm Speed 2",
	},
	{
		"name": "Farm Speed 2",
		"available": false,
		"description": "Your farmers will work much faster",
		"cost": 5000,
		"eval": "increase_farm_speed(3)",
		"next_unlock": "Farm Speed 3",
	},
	{
		"name": "Farm Speed 3",
		"available": false,
		"description": "Your farmers will work incredibly fast",
		"cost": 20000,
		"eval": "increase_farm_speed(4)",
		"next_unlock": "",
	},
	{
		"name": "Farm Output 1",
		"available": true,
		"description": "Your farms will produce more food",
		"cost": 500,
		"eval": "increase_farm_val(2)",
		"next_unlock": "Farm Output 2",
	},
	{
		"name": "Farm Output 2",
		"available": false,
		"description": "Your farms will produce evemt more food",
		"cost": 5000,
		"eval": "increase_farm_val(3)",
		"next_unlock": "Farm Output 3",
	},
	{
		"name": "Farm Output 3",
		"available": false,
		"description": "Your farms will produce a huge amount of food",
		"cost": 20000,
		"eval": "increase_farm_val(8)",
		"next_unlock": "",
	},
	{
		"name": "Store Speed 1",
		"available": true,
		"description": "Your stores will sell food faster",
		"cost": 100,
		"eval": "increase_store_speed(1)",
		"next_unlock": "Store Speed 2",
	},
	{
		"name": "Store Speed 2",
		"available": false,
		"description": "Your stores will sell food even faster",
		"cost": 1000,
		"eval": "increase_store_speed(1)",
		"next_unlock": "Store Speed 3",
	},
	{
		"name": "Store Speed 3",
		"available": false,
		"description": "Your stores will sell food super fast",
		"cost": 2500,
		"eval": "increase_store_speed(1)",
		"next_unlock": "",
	},
	{
		"name": "Store Prices 1",
		"available": true,
		"description": "Your stores will sell food for more profit",
		"cost": 200,
		"eval": "increase_store_val(25)",
		"next_unlock": "Store Prices 2",
	},
	{
		"name": "Store Prices 2",
		"available": false,
		"description": "Your stores will sell food for even more profit",
		"cost": 2000,
		"eval": "increase_store_val(25)",
		"next_unlock": "Store Prices 3",
	},
	{
		"name": "Store Prices 3",
		"available": false,
		"description": "Your stores will sell food for ridiculous profit",
		"cost": 20000,
		"eval": "increase_store_val(25)",
		"next_unlock": "",
	},
]
