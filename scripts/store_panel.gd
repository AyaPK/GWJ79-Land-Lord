class_name StorePanel extends PanelContainer

@onready var icon: TextureRect = $HBoxContainer/icon
@onready var item_name: Label = $HBoxContainer/details/ItemName
@onready var cost: Label = $HBoxContainer/details/CostContainer/CoinContainer/Cost
@onready var food_cost: Label = $HBoxContainer/details/CostContainer/FoodContainer/FoodCost
@onready var desc: Label = $HBoxContainer/details/Desc
@onready var buy_button: Button = $HBoxContainer/buy_button

var resource: String

func _on_buy_button_pressed() -> void:
	var res: PackedScene = load(resource)
	var scene: Plot = res.instantiate()
	get_tree().get_first_node_in_group("main_scene").add_child(scene)
	var loc: Vector2 = Globals.hovered_tile.grid_position
	Globals.grid[loc] = item_name.text+""
	scene.global_position = Vector2(loc.x*64, loc.y*64)
	scene.update_grid_pos()
	scene.plotname = item_name.text+""
	Globals.hovered_tile.queue_free()
	_take_money()
	for node in get_tree().get_nodes_in_group("store_scenes"):
		node.queue_free()
	Ui.place.play()
	Globals.hovering_paused = false

func _process(_delta: float) -> void:
	if Globals.money < int(cost.text) or Globals.food < int(food_cost.text):
		buy_button.disabled = true
		buy_button.text = ""
		modulate = "aaaaaacc"
	else:
		modulate = "ffffffff"
		buy_button.disabled = false
		buy_button.text = "Buy"

func _take_money() -> void:
	Globals.money -= int(cost.text)
	Globals.food -= int(food_cost.text)

func _on_buy_button_mouse_entered() -> void:
	Ui.boop.play()
