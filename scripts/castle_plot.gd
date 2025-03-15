class_name CastlePlot extends Plot

@onready var progress: TextureProgressBar = $progress

@export var icon: Texture

var coin_speed: int = 1
var coin_val: int = 1
var click_strength: int = 100

func _ready() -> void:
	$HoverRect.hide()

func _process(delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += coin_speed
	else:
		Globals.money += coin_val
		progress.value = 0

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _on_mouse_entered() -> void:
	$HoverRect.show()
	hovered = true

func _on_mouse_exited() -> void:
	$HoverRect.hide()
	hovered = false
#
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		progress.value += click_strength
