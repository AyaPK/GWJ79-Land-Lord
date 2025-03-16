class_name OutputAnim extends Node2D

@export var icon: Texture
@export var y_offset: int = 0

@onready var amount: Label = $components/amount
@onready var animation: AnimationPlayer = $animation

func _ready() -> void:
	if icon:
		$components/icon.texture = icon
	global_position.y -= y_offset
