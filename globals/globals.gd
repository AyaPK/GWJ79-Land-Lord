extends Node

var grid_size: int = 64
var money: int = 1500
var population: int = 1

var grid: Dictionary = {}
var owned: int = 0
var current_cost: int = 50

var hovering_paused: bool = false
var hovered_tile: Plot
