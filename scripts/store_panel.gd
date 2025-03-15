class_name StorePanel extends PanelContainer

@onready var icon: TextureRect = $HBoxContainer/icon
@onready var item_name: Label = $HBoxContainer/details/ItemName
@onready var cost: Label = $HBoxContainer/details/Cost
@onready var desc: Label = $HBoxContainer/details/Desc
@onready var buy_button: Button = $HBoxContainer/buy_button

var resource: String

func _on_buy_button_pressed() -> void:
	var res: PackedScene = load(resource)
	var scene: Plot = res.instantiate()
	get_tree().get_first_node_in_group("main_scene").add_child(scene)
	var loc: Vector2 = Globals.hovered_tile.grid_position
	Globals.grid[loc] = "item_name"
	scene.global_position = Vector2(loc.x*64, loc.y*64)
	scene.update_grid_pos()
	Globals.hovered_tile.queue_free()
	for node in get_tree().get_nodes_in_group("store_scenes"):
		node.queue_free()
	get_tree().get_first_node_in_group("main_scene").generate_locked_tiles(scene.grid_position)
	Globals.hovering_paused = false

func _process(delta: float) -> void:
	if Globals.money < int(cost.text):
		buy_button.disabled = true
		buy_button.text = ""
	else:
		buy_button.disabled = false
		buy_button.text = "Buy"
