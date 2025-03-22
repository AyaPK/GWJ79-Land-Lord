class_name PlotLake extends Plot

func _ready() -> void:
	super()
	$HoverRect.hide()
	if !Buyables.is_unlocked("Small Farm"):
		Ui.unlock_item("Small Farm")
	if !Buyables.is_unlocked("Gold Mine"):
		Ui.unlock_item("Gold Mine")

func _process(_delta: float) -> void:
	pass
