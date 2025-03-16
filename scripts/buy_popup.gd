class_name BuyPopup extends PanelContainer

func _ready() -> void:
	Globals.hovering_paused = true
	$menu/bottom/yes.pressed.connect(_on_yes_pressed)
	$menu/bottom/no.pressed.connect(_on_no_pressed)
	$menu/top/Label.text = "Pay "+str(Globals.current_cost)+" coins for this land?"
	for c in get_parent().get_children():
		if c is BuyPopup:
			if c != self:
				c.queue_free()

func _on_yes_pressed() -> void:
	Globals.hovering_paused = false
	Property.buy_confirmed.emit()
	queue_free()

func _on_no_pressed() -> void:
	Globals.hovering_paused = false
	for callable in Property.buy_confirmed.get_connections():
		Property.buy_confirmed.disconnect(callable["callable"])
	for _c in get_tree().get_nodes_in_group("plots"):
		_c.hovered = false
	Globals.hovered_tile.hovered = false
	queue_free()
