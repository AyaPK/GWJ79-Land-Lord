class_name PlotTemplate extends Plot

func _ready() -> void:
	$HoverRect.hide()

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		pass
