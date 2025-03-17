extends Node

const STORE_POPUP = preload("res://scenes/popups/store_popup.tscn")
const UPGRADE_POPUP = preload("res://scenes/popups/upgrade_popup.tscn")

var upgrades: Dictionary = {
	"Castle": {
		"speed": 0,
		"val": 0,
	},
	"Farm": {
		"speed": 0,
		"val": 0,
	},
	"Store": {
		"speed": 0,
		"val": 0,
	}
}

@warning_ignore("unused_signal")
signal buy_confirmed

func _check_castle_exists() -> bool:
	for _c in get_tree().get_nodes_in_group("plots"):
		if _c is CastlePlot:
			return true
	return false

func _check_lake_exists() -> bool:
	for _c in get_tree().get_nodes_in_group("plots"):
		if _c is PlotLake:
			return true
	return false

func _check_village_exists() -> bool:
	for _c in get_tree().get_nodes_in_group("plots"):
		if _c is PlotVillage:
			return true
	return false
