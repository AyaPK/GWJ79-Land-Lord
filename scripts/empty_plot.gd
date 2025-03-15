class_name EmptyPlot extends Plot

func _ready() -> void:
	$HoverRect.hide()
	$Button.hide()

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _on_mouse_entered() -> void:
	$HoverRect.show()
	$Button.show()
	hovered = true

func _on_mouse_exited() -> void:
	$HoverRect.hide()
	$Button.hide()
	hovered = false
#
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("click") and hovered:
		#print(grid_position)
