class_name LockedPlot extends Plot

var cost: int = 50

func _ready() -> void:
	$HoverRect.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		print(grid_position)
