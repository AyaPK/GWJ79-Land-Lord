class_name IronPlot extends Plot

@onready var progress: TextureProgressBar = $progress

var iron_speed: int = 1
var iron_amount: int = 1

func _ready() -> void:
	$HoverRect.hide()

func _process(delta: float) -> void:
	super(delta)
	if progress.value < progress.max_value:
		progress.value += iron_speed
	else:
		Globals.iron += iron_amount
		progress.value = 0
		$output_host.amount.text = "+"+str(iron_amount)
		$output_host.animation.play("anim")

func _input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("click") and hovered:
		pass
