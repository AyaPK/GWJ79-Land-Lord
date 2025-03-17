class_name CastlePlot extends Plot

@onready var progress: TextureProgressBar = $progress

var coin_speed: int = 1
var coin_val: int = 2
var click_strength: int = 50

func _ready() -> void:
	super()
	$HoverRect.hide()
	if Buyables.buyables["Castle"]["cost"] == 0:
		Buyables.buyables["Castle"]["cost"] = 5000
	else:
		Buyables.buyables["Castle"]["cost"] *= 10
	Buyables.buyables["Castle"]["description"] = "Taxes citizens to generate a modest amount of gold.\nClick it to generate gold faster!"
	if !Buyables.is_unlocked("Village"):
		Ui.unlock_item("Village")

func _process(_delta: float) -> void:
	if progress.value < progress.max_value:
		progress.value += coin_speed + Property.upgrades["Castle"]["speed"]
	else:
		Globals.money += floori((coin_val+Property.upgrades["Castle"]["val"]) * Globals.population)
		progress.value = 0
		$output.amount.text = "+"+str(floori((coin_val+Property.upgrades["Castle"]["val"]) * Globals.population))
		$output.animation.play("anim")

func update_grid_pos() -> void:
	grid_position = Vector2(global_position.x/64, global_position.y/64)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and hovered:
		if Globals.destroy_mode and destroyable:
			var empty_plot: EmptyPlot = EMPTY_PLOT.instantiate()
			get_tree().get_first_node_in_group("main_scene").add_child(empty_plot)
			empty_plot.global_position = global_position
			empty_plot.update_grid_pos()
			queue_free()
		else:
			progress.value += click_strength

func _on_build() -> void:
	pass

func _on_destroy() -> void:
	pass
