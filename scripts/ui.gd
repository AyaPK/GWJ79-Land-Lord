extends CanvasLayer

func _process(delta: float) -> void:
	$HBoxContainer/HBoxContainer/CoinAmount.text = str(Globals.money)
