extends Node2D

const MAIN = preload("res://scenes/main.tscn")

@onready var load_game: Button = $CanvasLayer/VBoxContainer/LoadGame

func _ready() -> void:
	Ui.hide()
	var check := FileAccess.open(SaveManager.saveFile, FileAccess.READ)
	if !check:
		load_game.disabled = true
		return

func _on_new_game_pressed() -> void:
	$Ding.play()
	await $Ding.finished
	Ui.show()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_load_game_pressed() -> void:
	$Ding.play()
	await $Ding.finished
	Globals.new_game = false
	Globals.load_game = true
	SaveManager.load_stats()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_new_game_mouse_entered() -> void:
	$ButtonBoop.play()

func _on_load_game_mouse_entered() -> void:
	$ButtonBoop.play()

func _on_credits_mouse_entered() -> void:
	$ButtonBoop.play()
