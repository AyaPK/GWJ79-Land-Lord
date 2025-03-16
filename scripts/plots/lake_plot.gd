class_name PlotLake extends Plot

func _ready() -> void:
	$HoverRect.hide()
	Buyables.buyables["Farmland"]["available"] = true

func _process(_delta: float) -> void:
	pass
