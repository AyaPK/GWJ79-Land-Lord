class_name PlotTemplate extends Plot

func _ready() -> void:
	$HoverRect.hide()

func _process(delta: float) -> void:
	super(delta)

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _on_build() -> void:
	pass

func _on_destroy() -> void:
	pass
