extends PanelContainer

const STORE_PANEL = preload("res://scenes/popups/store_panel.tscn")
const CLOSE_BUTTON = preload("res://scenes/popups/close_button.tscn")
@onready var items: VBoxContainer = $VBoxContainer/items_scroller/items
@onready var v_box_container: VBoxContainer = $VBoxContainer


func _ready() -> void:
	for buyable: String in Buyables.buyables:
		var store_panel: StorePanel = STORE_PANEL.instantiate()
		items.add_child(store_panel)
		store_panel.icon.texture = load(Buyables.buyables[buyable]["icon"])
		store_panel.item_name.text = buyable
		store_panel.cost.text = "Cost: "+str(Buyables.buyables[buyable]["cost"])
		store_panel.desc.text = "Cost: "+str(Buyables.buyables[buyable]["description"])
	var close_button: Button = CLOSE_BUTTON.instantiate()
	v_box_container.add_child(close_button)
