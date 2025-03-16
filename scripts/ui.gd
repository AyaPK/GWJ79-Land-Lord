extends CanvasLayer

const BOMB = preload("res://art/bomb.png")
const BOMB_SELECTED = preload("res://art/bomb_selected.png")

func _process(_delta: float) -> void:
	$HBoxContainer/VBoxContainer/coins/CoinAmount.text = str(Globals.money)
	$HBoxContainer/VBoxContainer/population/PopAmount.text = str(Globals.population)
	$HBoxContainer/VBoxContainer/food/FoodAmount.text = str(Globals.food)

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
