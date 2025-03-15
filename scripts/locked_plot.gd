class_name LockedPlot extends Plot

var cost: int = 50

const EMPTY_PLOT = preload("res://scenes/plots/empty_plot.tscn")
const BUY_POPUP = preload("res://scenes/popups/buy_popup.tscn")

func _ready() -> void:
	$HoverRect.hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		_buy()

func _buy() -> void:
	Globals.current_cost = 50 * (Globals.owned+1)
	if Globals.money >= Globals.current_cost:
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
	Globals.grid[grid_position] = "empty"
	Globals.owned += 1
	get_parent().add_child(plot)
	queue_free()
