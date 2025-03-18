extends PanelContainer

const STORE_PANEL = preload("res://scenes/popups/store_panel.tscn")
const CLOSE_BUTTON = preload("res://scenes/popups/close_button.tscn")
@onready var items: VBoxContainer = $VBoxContainer/items_scroller/items
@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	for buyable: String in Buyables.buyables:
		if Buyables.buyables[buyable]["available"]:
			var store_panel: StorePanel = STORE_PANEL.instantiate()
			items.add_child(store_panel)
			store_panel.icon.texture = load(Buyables.buyables[buyable]["icon"])
			store_panel.item_name.text = buyable
			store_panel.cost.text = str(Buyables.buyables[buyable]["cost"])
			store_panel.food_cost.text = str(Buyables.buyables[buyable]["food_cost"])
			store_panel.desc.text = Buyables.buyables[buyable]["description"]
			store_panel.resource = Buyables.buyables[buyable]["path"]
	var close_button: Button = CLOSE_BUTTON.instantiate()
	close_button.pressed.connect(_on_close_pressed)
	v_box_container.add_child(close_button)
	Globals.zooming_paused = true

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
