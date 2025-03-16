extends Camera2D

const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 4.0
const ZOOM_INCREMENT: float = 0.2
const ZOOM_RATE: float = 10.0
const CAMERA_SPEED: float = 400.0
const TOUCH_DRAG_SENSITIVITY: float = 0.6  # Reduce touch drag speed
const PINCH_THRESHOLD: float = 10.0  # Increased threshold for pinch detection
const DRAG_DECELERATION: float = 5.0  # Higher value = faster deceleration

var _target_zoom: float = 4.0
var _touch_points = {}
var _last_pinch_distance: float = 0.0
var _is_dragging: bool = false
var _velocity: Vector2 = Vector2.ZERO
var _last_drag_position: Vector2 = Vector2.ZERO
var _last_drag_time: float = 0.0

func _ready() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	zoom = lerp(zoom, _target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	
	if _velocity.length() > 0:
		position += _velocity * delta
		_velocity = _velocity.move_toward(Vector2.ZERO, DRAG_DECELERATION * delta * _velocity.length())
	
	var direction := Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		position += direction * CAMERA_SPEED * delta

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom
	elif event is InputEventMouseButton:
		if event.is_pressed():
			if !Globals.zooming_paused:
				if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					zoom_in()
				elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
					zoom_out()
	
	elif event is InputEventScreenTouch:
		if event.pressed:
			_touch_points[event.index] = event.position
			if _touch_points.size() == 1:
				_last_drag_position = event.position
				_last_drag_time = Time.get_ticks_msec() / 1000.0
				_velocity = Vector2.ZERO
		else:
			_touch_points.erase(event.index)
			if _touch_points.is_empty():
				_last_pinch_distance = 0.0
				_is_dragging = false
				
				if _is_dragging:
					var current_time = Time.get_ticks_msec() / 1000.0
					var time_diff = current_time - _last_drag_time
					if time_diff > 0 and time_diff < 0.1:  # Only apply flick if release was quick
						var drag_diff = (event.position - _last_drag_position) / zoom.x
						_velocity = drag_diff * TOUCH_DRAG_SENSITIVITY / time_diff
	
	elif event is InputEventScreenDrag:
		_touch_points[event.index] = event.position
		
		if _touch_points.size() == 1:
			_is_dragging = true
			position -= event.relative * TOUCH_DRAG_SENSITIVITY / zoom
			_last_drag_position = event.position
			_last_drag_time = Time.get_ticks_msec() / 1000.0
			_velocity = Vector2.ZERO 
		
		elif _touch_points.size() == 2:
			var touch_points = _touch_points.values()
			var current_distance = touch_points[0].distance_to(touch_points[1])
			
			if _last_pinch_distance != 0:
				var distance_diff = current_distance - _last_pinch_distance
				if abs(distance_diff) > PINCH_THRESHOLD:
					if distance_diff > 0:
						zoom_out()
					else:
						zoom_in()
			
			_last_pinch_distance = current_distance
			_velocity = Vector2.ZERO

func zoom_in() -> void:
	_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)

func zoom_out() -> void:
	_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
