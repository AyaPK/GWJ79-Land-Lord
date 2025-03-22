extends Node2D

const MAIN = preload("res://scenes/main.tscn")

@onready var load_game: Button = $CanvasLayer/VBoxContainer/LoadGame
@onready var settings_panel: PanelContainer = $CanvasLayer/SettingsPanel
@onready var musiccheck: CheckBox = $CanvasLayer/SettingsPanel/VBoxContainer/HBoxContainer/musiccheck
@onready var sfxcheck: CheckBox = $CanvasLayer/SettingsPanel/VBoxContainer/HBoxContainer2/sfxcheck
@onready var button: Button = $CanvasLayer/SettingsPanel/VBoxContainer/Button
@onready var v_box_container: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var credits_container: PanelContainer = $CanvasLayer/CreditsContainer

func _ready() -> void:
	Ui.hide()
	var check := FileAccess.open(SaveManager.saveFile, FileAccess.READ)
	if !check:
		load_game.disabled = true
		return
	settings_panel.hide()

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

func _on_settings_button_pressed() -> void:
	settings_panel.show()
	v_box_container.hide()

func _on_button_pressed() -> void:
	settings_panel.hide()
	v_box_container.show()

func _on_sfxcheck_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, !toggled_on)

func _on_musiccheck_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2, !toggled_on)

func _on_closecredits_pressed() -> void:
	credits_container.hide()
	v_box_container.show()

func _on_credits_pressed() -> void:
	credits_container.show()
	v_box_container.hide()
