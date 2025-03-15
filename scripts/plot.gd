class_name Plot extends Area2D

@export var plot_scene: Plot

var grid_position: Vector2
var hovered: bool = false
var locked: bool = true
var empty_plot: bool = false

func _ready() -> void:
	$HoverRect.hide()
	$Button.hide()

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _on_mouse_entered() -> void:
	$HoverRect.show()
	if empty_plot:
		$Button.show()
	hovered = true

func _on_mouse_exited() -> void:
	$HoverRect.hide()
	if empty_plot:
		$Button.hide()
	hovered = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		print(grid_position)
