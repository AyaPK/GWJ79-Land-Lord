class_name PlotVillage extends Plot

func _ready() -> void:
	super()
	$HoverRect.hide()
	Globals.population = calc_pop()
	if !Buyables.is_unlocked("Lake"):
		Ui.unlock_item("Lake")
	if !Buyables.is_unlocked("Store"):
		Ui.unlock_item("Store")

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass

func _on_destroy() -> void:
	Globals.population = calc_pop()

func calc_pop() -> int:
	var population: int = 0
	for t in Globals.grid:
		if Globals.grid[t] == "Village":
			population += 10
		if Globals.grid[t] == "Town":
			population += 10
	return population
