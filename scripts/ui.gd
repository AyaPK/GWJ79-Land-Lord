extends CanvasLayer

func _process(_delta: float) -> void:
	$HBoxContainer/VBoxContainer/coins/CoinAmount.text = str(Globals.money)
	$HBoxContainer/VBoxContainer/population/PopAmount.text = str(Globals.population)
