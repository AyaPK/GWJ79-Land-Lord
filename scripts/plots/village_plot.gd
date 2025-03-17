class_name PlotVillage extends Plot

func _ready() -> void:
	$HoverRect.hide()
	Globals.population += 10
	if !Buyables.is_unlocked("Lake"):
		Ui.unlock_item("Lake")
	if !Buyables.is_unlocked("Store"):
		Ui.unlock_item("Store")

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _on_destroy() -> void:
	Globals.population -= 10
