class_name StorePlot extends Plot

@onready var progress: TextureProgressBar = $progress

var coin_speed: int = 1
var coin_val: int = 5
var click_strength: int = 200

func _ready() -> void:
	$HoverRect.hide()


func _process(delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += coin_speed
	else:
		Globals.money += coin_val * _find_adjacent_villages()
		progress.value = 0

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _find_adjacent_villages() -> int:
	var count: int = 0
	var center: Vector2 = grid_position
	for x in range(-1, 2):
		for y in range(-1, 2):
			var pos: Vector2 = Vector2(center.x+x, center.y+y)
			if pos == center or pos not in Globals.grid:
				continue
			if Globals.grid[pos] == "Village":
				count += 1
	return count
