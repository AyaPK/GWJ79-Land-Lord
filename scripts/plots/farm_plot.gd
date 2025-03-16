class_name PlotTemplate extends Plot

@onready var progress: TextureProgressBar = $progress

var food_speed: int = 1
var food_val: int = 1

func _ready() -> void:
	$HoverRect.hide()

func _process(delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += food_speed
	else:
		Globals.food += (food_val * _find_adjacent_lakes())
		progress.value = 0

func _input(event: InputEvent) -> void:
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
