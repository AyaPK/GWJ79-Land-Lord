extends CanvasLayer

const BOMB = preload("res://art/bomb.png")
const BOMB_SELECTED = preload("res://art/bomb_selected.png")
@onready var unlocked_icon: TextureRect = $UnlockedContainer/VBoxContainer/UnlockedIcon
@onready var unlocked_name: Label = $"UnlockedContainer/VBoxContainer/Unlocked Name"
@onready var unlock_animation: AnimationPlayer = $UnlockedContainer/UnlockAnimation

var unlock_queue: Array = []

func _process(_delta: float) -> void:
	$HBoxContainer/VBoxContainer/coins/CoinAmount.text = str(Globals.money)
	$HBoxContainer/VBoxContainer/population/PopAmount.text = str(Globals.population)
	$HBoxContainer/VBoxContainer/food/FoodAmount.text = str(Globals.food)
	$HBoxContainer/VBoxContainer/iron/IronAmount.text = str(Globals.iron)

func _on_destroy_button_pressed() -> void:
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
	var item_name: String = unlock_queue[0]
	var image: Texture = load(Buyables.buyables[item_name]["icon"])
	unlocked_icon.texture = image
	unlocked_name.text = item_name

func remove_unlock_from_queue() -> void:
	unlock_queue.pop_front()
