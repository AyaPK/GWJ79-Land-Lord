class_name FarmPlot extends Plot

@onready var progress: TextureProgressBar = $progress

var food_speed: int = 1
var food_val: int = 1

func _ready() -> void:
	super()
	$HoverRect.hide()
	if Buyables.buyables["Small Farm"]["cost"] == 100:
		Buyables.buyables["Small Farm"]["cost"] = 500
	if !Buyables.is_unlocked("Iron Mine"):
		Ui.unlock_item("Iron Mine")

func _process(_delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += food_speed + Property.upgrades["Farm"]["speed"]
	else:
		var to_add: int = (food_val + Property.upgrades["Farm"]["val"]) * _find_adjacent_lakes()
		Globals.food += to_add
		progress.value = 0
		$output_host.amount.text = "+"+str(to_add)
		$output_host.animation.play("anim")

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _find_adjacent_lakes() -> int:
	var count: int = 0
	var center: Vector2 = grid_position
	for x in range(-1, 2):
		for y in range(-1, 2):
			var pos: Vector2 = Vector2(center.x+x, center.y+y)
			if pos == center or pos not in Globals.grid:
				continue
			if Globals.grid[pos] == "Lake":
				count += 1
	return count
