class_name Level extends Node2D

const PLOT = preload("res://scenes/plots/locked_plot.tscn")

func _ready() -> void:
	for x in range(0, 64, 64):
		for y in range(0, 64, 64):
			var plot: Area2D = PLOT.instantiate()
			plot.global_position = Vector2(x, y)
			add_child(plot)
			plot.update_grid_pos()
			Globals.grid[Vector2(x, y)] = "locked"
