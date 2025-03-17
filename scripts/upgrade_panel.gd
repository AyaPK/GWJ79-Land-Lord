class_name UpgradePanel extends PanelContainer

@onready var upgrade_name: Label = $HBoxContainer/VBoxContainer/upgrade_name
@onready var cost: Label = $HBoxContainer/VBoxContainer/HBoxContainer/details/CostContainer/CoinContainer/Cost
@onready var desc: Label = $HBoxContainer/VBoxContainer/HBoxContainer/details/Desc
@onready var buy_button: Button = $HBoxContainer/buy_button

var eval: String
var unlock: String

func _process(_delta: float) -> void:
	if Globals.money < int(cost.text):
		buy_button.hide()
	else:
		buy_button.show()

func _on_buy_button_pressed() -> void:
	Globals.money -= int(cost.text)
	var exp = Expression.new()
	exp.parse(eval)
	exp.execute([], self)
	queue_free()

func increase_castle_speed(amount: int) -> void:
	Property.upgrades["Castle"]["speed"] += amount

func increase_castle_val(amount: int) -> void:
	Property.upgrades["Castle"]["val"] += amount
