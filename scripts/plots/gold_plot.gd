class_name GoldPlot extends Plot

@onready var progress: TextureProgressBar = $progress

var gold_speed: int = 3
var gold_amount: int = 30

func _ready() -> void:
	super()
	$HoverRect.hide()

func _process(delta: float) -> void:
	super(delta)
	if progress.value < progress.max_value:
		progress.value += gold_speed
	else:
		Globals.iron += gold_amount * _find_adjacent_residences()
		progress.value = 0
		$output_host.amount.text = "+"+str(int(gold_amount * _find_adjacent_residences()))
		$output_host.animation.play("anim")

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _find_adjacent_residences() -> float:
	var count: float = 0
	var center: Vector2 = grid_position
	for x in range(-1, 2):
		for y in range(-1, 2):
			var pos: Vector2 = Vector2(center.x+x, center.y+y)
			if pos == center or pos not in Globals.grid:
				continue
			if Globals.grid[pos] == "Village":
				count += 1
			elif Globals.grid[pos] == "Town":
				count += 2
	return count
