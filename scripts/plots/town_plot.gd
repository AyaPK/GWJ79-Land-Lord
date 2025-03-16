class_name PlotTown extends Plot

func _ready() -> void:
	$HoverRect.hide()
	Globals.population += 50

func _process(delta: float) -> void:
	super(delta)

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass
