class_name EmptyPlot extends Plot

func _ready() -> void:
	super()
	$HoverRect.hide()
	$Button.hide()

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _on_mouse_entered() -> void:
	if !Globals.hovering_paused:
		Globals.hovered_tile = self
		$HoverRect.show()
		$Button.show()
		hovered = true

func _on_mouse_exited() -> void:
	if !Globals.hovering_paused:
		$HoverRect.hide()
		$Button.hide()
		hovered = false

func _on_button_pressed() -> void:
	Ui.boop_2.play()
	Globals.hovering_paused = true
	var store: PanelContainer = Property.STORE_POPUP.instantiate()
	Ui.add_child(store)
