extends PanelContainer

func _ready() -> void:
	$menu/bottom/yes.pressed.connect(_on_yes_pressed)
	$menu/bottom/no.pressed.connect(_on_no_pressed)
	$menu/top/Label.text = "Pay "+str(Globals.current_cost)+" coins for this land?"

func _on_yes_pressed() -> void:
	print("enene")
	Property.buy_confirmed.emit()
	queue_free()

func _on_no_pressed() -> void:
	for callable in Property.buy_confirmed.get_connections():
		Property.buy_confirmed.disconnect(callable["callable"])
	queue_free()
