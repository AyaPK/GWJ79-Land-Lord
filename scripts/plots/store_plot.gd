class_name StorePlot extends Plot

@onready var progress: TextureProgressBar = $progress

@onready var output: OutputAnim = $output
@onready var output_2: OutputAnim = $output2

var coin_speed: int = 1
var coin_val: int = 50
var click_strength: int = 200

func _ready() -> void:
	super()
	$HoverRect.hide()
	if !Buyables.is_unlocked("Town"):
		Ui.unlock_item("Town")

func _process(_delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += coin_speed
	else:
		if Globals.food > 0:
			var to_sell: int = clamp(_find_adjacent_residences(), 0, Globals.food)
			Globals.money += coin_val * to_sell
			Globals.food -= to_sell
			progress.value = 0
			$output.amount.text = "+"+str(coin_val * to_sell)
			$output.animation.play("anim")
			$output2.amount.text = "-"+str(to_sell)
			$output2.animation.play("anim")

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _find_adjacent_residences() -> int:
	var count: int = 0
	var center: Vector2 = grid_position
	for x in range(-1, 2):
		for y in range(-1, 2):
			var pos: Vector2 = Vector2(center.x+x, center.y+y)
			if pos == center or pos not in Globals.grid:
				continue
			if Globals.grid[pos] == "Village" or Globals.grid[pos] == "Town":
				count += 1
	return count
