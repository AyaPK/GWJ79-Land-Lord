class_name LockedPlot extends Plot

var cost: int = 50

const PLOT = preload("res://scenes/plot.tscn")

func _ready() -> void:
	$HoverRect.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		_buy()

func _buy() -> void:
	if Globals.money >= cost:
		Globals.money -= cost
		var plot: Plot = PLOT.instantiate()
		plot.locked = false
		plot.global_position = global_position
		Globals.grid[grid_position] = "empty"
		get_parent().add_child(plot)
		queue_free()
