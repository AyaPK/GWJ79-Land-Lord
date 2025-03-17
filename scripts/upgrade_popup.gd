class_name UpgradePopup extends PanelContainer

const UPGRADE_PANEL = preload("res://scenes/popups/upgrade_panel.tscn")
@onready var items: VBoxContainer = $VBoxContainer/items_scroller/items


func _ready() -> void:
	_populate_upgrades()
	Globals.hovering_paused = true
	Globals.zooming_paused = true

func _populate_upgrades() -> void:
	for upgrade: Dictionary in Buyables.upgrades:
		if upgrade["available"]:
			var panel: UpgradePanel = UPGRADE_PANEL.instantiate()
			items.add_child(panel)
			panel.upgrade_name.text = upgrade["name"]
			panel.cost.text = str(upgrade["cost"])
			panel.desc.text = upgrade["description"]
			panel.eval = upgrade["eval"]
			panel.unlock = upgrade["next_unlock"]
