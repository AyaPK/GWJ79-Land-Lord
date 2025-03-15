extends CanvasLayer

func _process(_delta: float) -> void:
	$HBoxContainer/HBoxContainer/CoinAmount.text = str(Globals.money)
