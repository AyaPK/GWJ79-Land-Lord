extends Node

var grid_size: int = 64
var money: int = 500
var population: int = 0
var food: int = 0
var iron: int = 0

var grid: Dictionary = {}
var owned: int = 0
var current_cost: int = 50

var hovering_paused: bool = false
var zooming_paused: bool = false
var destroy_mode: bool = false
var hovered_tile: Plot

var new_game: bool = true
var load_game: bool = false
