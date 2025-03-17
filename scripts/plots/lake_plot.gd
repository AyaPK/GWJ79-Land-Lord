class_name PlotLake extends Plot

func _ready() -> void:
	super()
	$HoverRect.hide()
	if !Buyables.is_unlocked("Small Farm"):
		Ui.unlock_item("Small Farm")

func _process(_delta: float) -> void:
	pass
