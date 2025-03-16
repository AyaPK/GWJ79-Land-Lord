extends Node

const STORE_POPUP = preload("res://scenes/popups/store_popup.tscn")

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
