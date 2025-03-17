extends Node2D

const MAIN = preload("res://scenes/main.tscn")

func _ready() -> void:
	Ui.hide()

func _on_new_game_pressed() -> void:
	Ui.show()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
