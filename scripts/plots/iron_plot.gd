class_name IronPlot extends Plot

@onready var progress: TextureProgressBar = $progress

var iron_speed: int = 1
var iron_amount: int = 1

func _ready() -> void:
	super()
	$HoverRect.hide()

func _process(delta: float) -> void:
	super(delta)
	if progress.value < progress.max_value:
		progress.value += iron_speed + _find_adjacent_residences()
	else:
		Globals.iron += iron_amount
		progress.value = 0
		$output_host.amount.text = "+"+str(iron_amount)
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
