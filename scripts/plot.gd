class_name Plot extends Area2D

const EMPTY_PLOT = preload("res://scenes/plots/empty_plot.tscn")

var grid_position: Vector2
var hovered: bool = false
@export var plotname: String
@export var destroyable: bool = false

@export var icon: Texture

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
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

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		if Globals.destroy_mode and destroyable:
			var empty_plot: EmptyPlot = EMPTY_PLOT.instantiate()
			get_tree().get_first_node_in_group("main_scene").add_child(empty_plot)
			empty_plot.global_position = global_position
			empty_plot.update_grid_pos()
			get_tree().get_first_node_in_group("main_scene").play_explosion(grid_position)
			Globals.money += Buyables.buyables[plotname]["cost"]
			Globals.grid[grid_position] = "Empty"
			_on_destroy()
			queue_free()

func _on_build() -> void:
	pass

func _on_destroy() -> void:
	pass
	
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	mouse_entered.disconnect(_on_mouse_entered)
	mouse_exited.disconnect(_on_mouse_exited)
