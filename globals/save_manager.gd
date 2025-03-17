extends Node

const saveFile: = "user://savefile.tscn"
const saveStats: = "user://savefile.sav"

signal game_saved

var current_save: Dictionary = {
	money = 0,
	food = 0,
	iron = 0,
	current_cost = 0,
	buyables = {},
	grid = {},
}

func create_package(_node:Node)->PackedScene:
	_set_owner(_node, _node)
	var package: = PackedScene.new()
	package.pack(_node)
	return package

func _set_owner(_node:Node, _owner:Node)->void:
	for child in _node.get_children():
		child.owner = _owner
		_set_owner(child, _owner)

func save_stats() -> void:
	current_save["money"] = Globals.money
	current_save["food"] = Globals.food
	current_save["iron"] = Globals.iron
	current_save["buyables"] = Buyables.buyables
	current_save["grid"] = Globals.grid
	current_save["current_cost"] = Globals.current_cost
	var file := FileAccess.open(saveStats, FileAccess.WRITE)
	var save_json: String = JSON.stringify(current_save)
	file.store_line(save_json)
	file.close()
	game_saved.emit()

func load_stats() -> void:
	var file := FileAccess.open(saveStats, FileAccess.READ)
	var json: JSON = JSON.new()
	json.parse(file.get_line())
	var save_dict: Dictionary = json.get_data() as Dictionary
	current_save = save_dict

	Globals.money = current_save["money"]
	Globals.food = current_save["food"]
	Globals.iron = current_save["iron"]
	Buyables.buyables = current_save["buyables"]
	Globals.current_cost = current_save["current_cost"]
	Globals.grid = {}

	for key: String in current_save["grid"]:
		var cleaned_key: String = key.trim_prefix("(").trim_suffix(")") 
		var coords: PackedStringArray = cleaned_key.split(", ")

		if coords.size() == 2:
			var vec2_key: Vector2 = Vector2(float(coords[0]), float(coords[1]))
			Globals.grid[vec2_key] = current_save["grid"][key]
