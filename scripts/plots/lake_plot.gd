class_name PlotLake extends Plot

func _ready() -> void:
	$HoverRect.hide()

func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		pass
