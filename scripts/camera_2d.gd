extends Camera2D

const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 4.0
const ZOOM_INCREMENT: float = 0.2
const ZOOM_RATE: float = 10.0

var _target_zoom: float = 1.0

func _physics_process(delta: float) -> void:
	zoom = lerp(
		zoom,
		_target_zoom * Vector2.ONE,
		ZOOM_RATE * delta
		)
	set_physics_process(!is_equal_approx(zoom.x, _target_zoom))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_in()
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_out()

func zoom_in() -> void:
	_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)

func zoom_out() -> void:
	_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
	set_physics_process(true)
