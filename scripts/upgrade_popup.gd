class_name UpgradePopup extends PanelContainer

@onready var items: VBoxContainer = $VBoxContainer/items_scroller/items
@onready var v_box_container: VBoxContainer = $VBoxContainer

const CLOSE_BUTTON = preload("res://scenes/popups/close_button.tscn")
const UPGRADE_PANEL = preload("res://scenes/popups/upgrade_panel.tscn")

func _ready() -> void:
	_populate_upgrades()
	Globals.hovering_paused = true
	Globals.zooming_paused = true
	var close_button: Button = CLOSE_BUTTON.instantiate()
	close_button.pressed.connect(_on_close_pressed)
	v_box_container.add_child(close_button)
	Ui.upgrade_bought.connect(_refresh_panels)

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

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	Globals.hovering_paused = false
	Globals.zooming_paused = false
	for _c: Plot in get_tree().get_nodes_in_group("plots"):
		_c.hovered = false

func _on_close_pressed() -> void:
	Ui.close.play()
	queue_free()

func _refresh_panels() -> void:
	for _c in items.get_children():
		if _c:
			_c.queue_free()
			await _c.tree_exited
	_populate_upgrades()
