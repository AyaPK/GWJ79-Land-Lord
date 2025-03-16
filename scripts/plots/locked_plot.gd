class_name LockedPlot extends Plot

var cost: int = 50

const BUY_POPUP = preload("res://scenes/popups/buy_popup.tscn")

func _ready() -> void:
	$HoverRect.hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		_buy()

func _process(_delta: float) -> void:
	if !Globals.hovering_paused:
		$HoverRect.visible = hovered
	if hovered:
		Globals.current_cost = floori((50 * ((Globals.owned*1.4)+1)))
		$cost/Label.text = str(Globals.current_cost)
		$cost.show()
	else:
		$cost.hide()

func _buy() -> void:
	Globals.current_cost = floori((50 * ((Globals.owned*1.4)+1)))
	if Globals.money >= Globals.current_cost:
		Globals.hovering_paused = true
		hovered = false
		var buy_popup: PanelContainer = BUY_POPUP.instantiate()
		Ui.add_child(buy_popup)
		for callable in Property.buy_confirmed.get_connections():
			Property.buy_confirmed.disconnect(callable["callable"])
		Property.buy_confirmed.connect(_confirm_buy)

func _confirm_buy() -> void:
	Globals.money -= Globals.current_cost
	var plot: EmptyPlot = EMPTY_PLOT.instantiate()
	plot.global_position = global_position
	plot.update_grid_pos()
	Globals.grid[grid_position] = "empty"
	Globals.owned += 1
	get_parent().add_child(plot)
	get_tree().get_first_node_in_group("main_scene").generate_locked_tiles(plot.grid_position)
	queue_free()
