class_name PlotVillage extends Plot

func _ready() -> void:
	$HoverRect.hide()
	Globals.population += 10

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		pass
