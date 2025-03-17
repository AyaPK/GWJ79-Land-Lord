class_name UpgradePanel extends PanelContainer

@onready var upgrade_name: Label = $HBoxContainer/VBoxContainer/upgrade_name
@onready var cost: Label = $HBoxContainer/VBoxContainer/HBoxContainer/details/CostContainer/CoinContainer/Cost
@onready var desc: Label = $HBoxContainer/VBoxContainer/HBoxContainer/details/Desc
@onready var buy_button: Button = $HBoxContainer/buy_button

var eval: String
var unlock: String

func _process(_delta: float) -> void:
	if Globals.iron < int(cost.text):
		buy_button.hide()
	else:
		buy_button.show()

func _on_buy_button_pressed() -> void:
	Globals.iron -= int(cost.text)
	var expr: Expression = Expression.new()
	expr.parse(eval)
	expr.execute([], self)
	for ug: Dictionary in Buyables.upgrades:
		if ug["name"] == upgrade_name.text:
			ug["available"] = false
	if unlock != "":
		for ug: Dictionary in Buyables.upgrades:
			if ug["name"] == unlock:
				ug["available"] = true
	queue_free()

func increase_castle_speed(amount: int) -> void:
	Property.upgrades["Castle"]["speed"] += amount

func increase_castle_val(amount: int) -> void:
	Property.upgrades["Castle"]["val"] += amount

func increase_farm_speed(amount: int) -> void:
	Property.upgrades["Farm"]["speed"] += amount

func increase_farm_val(amount: int) -> void:
	Property.upgrades["Farm"]["val"] += amount

func increase_store_speed(amount: int) -> void:
	Property.upgrades["Store"]["speed"] += amount

func increase_store_val(amount: int) -> void:
	Property.upgrades["Store"]["val"] += amount
