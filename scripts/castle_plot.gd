class_name CastlePlot extends Plot

@onready var progress: TextureProgressBar = $progress

var coin_speed: int = 1
var coin_val: int = 1
var click_strength: int = 50

func _ready() -> void:
	$HoverRect.hide()
	if Buyables.buyables["Castle"]["cost"] == 0:
		Buyables.buyables["Castle"]["cost"] = 5000
	else:
		Buyables.buyables["Castle"]["cost"] *= 10
	Buyables.buyables["Castle"]["description"] = "Taxes citizens to generate a modest amount of gold.\nClick it to generate gold faster!"
	Buyables.buyables["Lake"]["available"] = true
	Buyables.buyables["Village"]["available"] = true

func _process(_delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += coin_speed
	else:
		Globals.money += coin_val * Globals.population
		progress.value = 0

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		progress.value += click_strength
