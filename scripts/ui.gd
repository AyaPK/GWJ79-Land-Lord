extends CanvasLayer

var createdPackage:PackedScene

const BOMB = preload("res://art/bomb.png")
const BOMB_SELECTED = preload("res://art/bomb_selected.png")
const CIPHER_CHIPTUNE = preload("res://audio/music/cipher_chiptune.mp3")

@onready var boop: AudioStreamPlayer = $Boop
@onready var boop_2: AudioStreamPlayer = $Boop2
@onready var close: AudioStreamPlayer = $Close
@onready var place: AudioStreamPlayer = $Place
@onready var cheated: AudioStreamPlayer = $Cheated
@onready var settings_panel: PanelContainer = $SettingsPanel
@onready var tutorial_panel: PanelContainer = $TutorialPanel

@onready var unlocked_icon: TextureRect = $UnlockedContainer/VBoxContainer/UnlockedIcon
@onready var unlocked_name: Label = $"UnlockedContainer/VBoxContainer/Unlocked Name"
@onready var unlock_animation: AnimationPlayer = $UnlockedContainer/UnlockAnimation
@onready var cipher: AudioStreamPlayer = $Cipher
@onready var musiccheck: CheckBox = $SettingsPanel/VBoxContainer/HBoxContainer/musiccheck
@onready var sfxcheck: CheckBox = $SettingsPanel/VBoxContainer/HBoxContainer2/sfxcheck

var unlock_queue: Array = []

func _ready() -> void:
	settings_panel.hide()
	musiccheck.button_pressed = true
	sfxcheck.button_pressed = true

func _process(_delta: float) -> void:
	$HBoxContainer/VBoxContainer/coins/CoinAmount.text = str(Globals.money)
	$HBoxContainer/VBoxContainer/population/PopAmount.text = str(Globals.population)
	$HBoxContainer/VBoxContainer/food/FoodAmount.text = str(Globals.food)
	$HBoxContainer/VBoxContainer/iron/IronAmount.text = str(Globals.iron)

func _on_destroy_button_pressed() -> void:
	if !Globals.hovering_paused:
		Globals.destroy_mode = !Globals.destroy_mode
		if Globals.destroy_mode:
			$DestroyContainer/DestroyButton/Bomb.texture = BOMB_SELECTED
		else:
			$DestroyContainer/DestroyButton/Bomb.texture = BOMB


func _on_destroy_button_mouse_entered() -> void:
	$DestroyContainer.modulate = "ffffffff"
	for _c in get_tree().get_nodes_in_group("plots"):
		_c.hovered = false

func _on_destroy_button_mouse_exited() -> void:
	$DestroyContainer.modulate = "ffffffaa"

func unlock_item(item_name: String) -> void:
	Buyables.buyables[item_name]["available"] = true
	unlock_queue.append(item_name)
	unlock_animation.queue("anim")

func get_item_details() -> void:
	$Ding.play()
	var item_name: String = unlock_queue[0]
	var image: Texture = load(Buyables.buyables[item_name]["icon"])
	unlocked_icon.texture = image
	unlocked_name.text = item_name

func remove_unlock_from_queue() -> void:
	unlock_queue.pop_front()

func _on_save_pressed() -> void:
	$saved.play("anim")
	SaveManager.save_stats()
	createdPackage = SaveManager.create_package(get_tree().get_first_node_in_group("main_scene"))
	if !createdPackage:
		return
	ResourceSaver.save(createdPackage, SaveManager.saveFile)

func _on_upgrades_pressed() -> void:
	if !Globals.hovering_paused:
		var popup: UpgradePopup = Property.UPGRADE_POPUP.instantiate()
		add_child(popup)

func _on_settings_button_pressed() -> void:
	if !Globals.hovering_paused:
		settings_panel.show()
		Globals.hovering_paused = true
		Globals.zooming_paused = true

func _on_button_pressed() -> void:
	settings_panel.hide()
	Globals.hovering_paused = false
	Globals.zooming_paused = false

func _on_musiccheck_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2, !toggled_on)

func _on_sfxcheck_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, !toggled_on)


func _on_closetutorial_pressed() -> void:
	tutorial_panel.hide()
