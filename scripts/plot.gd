class_name Plot extends Area2D

var grid_position: Vector2
var hovered: bool = false

@export var icon: Texture

func _ready() -> void:
	$HoverRect.hide()

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _process(_delta: float) -> void:
	$HoverRect.visible = hovered

func _on_mouse_entered() -> void:
	if !Globals.hovering_paused:
		Globals.hovered_tile = self
		$HoverRect.show()
		hovered = true

func _on_mouse_exited() -> void:
	if !Globals.hovering_paused:
		$HoverRect.hide()
	hovered = false
