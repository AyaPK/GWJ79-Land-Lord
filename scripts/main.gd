class_name Level extends Node2D

const PLOT = preload("res://scenes/plots/locked_plot.tscn")
const EXPLOSION = preload("res://scenes/explosion.tscn")

func _ready() -> void:
	if Globals.new_game:
		for x in range(0, 64, 64):
			for y in range(0, 64, 64):
				var plot: Area2D = PLOT.instantiate()
				plot.global_position = Vector2(x, y)
				add_child(plot)
				plot.update_grid_pos()
				Globals.grid[Vector2(x, y)] = "locked"
	elif Globals.load_game:
		Globals.load_game = false
		Ui.show()
		await get_tree().process_frame
		var file := ResourceLoader.load(SaveManager.saveFile)
		var parent: Node = get_tree().get_first_node_in_group("main_scene").get_parent()
		get_tree().get_first_node_in_group("main_scene").queue_free()
		var packageInstance: Node = file.instantiate()
		parent.add_child(packageInstance)
		for _c: Plot in get_tree().get_nodes_in_group("plots"):
			_c.update_grid_pos()

func generate_locked_tiles(center: Vector2) -> void:
	for x in range(-1, 2):
		for y in range(-1, 2):
			var pos: Vector2 = Vector2(center.x+x, center.y+y)
			if pos == center or pos in Globals.grid or pos.x < -18 or pos.y > 15 or pos.x > 17 or pos.y < -16:
				continue
			var locked_scene: LockedPlot = PLOT.instantiate()
			get_tree().get_first_node_in_group("main_scene").add_child(locked_scene)
			Globals.grid[pos] = "locked"
			locked_scene.global_position = Vector2(pos.x*64, pos.y*64)
			locked_scene.update_grid_pos()

func _on_node_success() -> void:
	Globals.money += 10000

func play_explosion(gridpos: Vector2) -> void:
	var explosion: GPUParticles2D = EXPLOSION.instantiate()
	var pos: Vector2 = Vector2(gridpos.x * 64 + 32, gridpos.y * 64 + 32)
	explosion.global_position = pos
	add_child(explosion)
	explosion.emitting = true
	await explosion.finished
	explosion.queue_free()
