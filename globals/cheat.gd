extends Node

# Cheat code
var sequence = [
	KEY_UP,
	KEY_UP,
	KEY_DOWN,
	KEY_DOWN,
	KEY_LEFT,
	KEY_RIGHT,
	KEY_LEFT,
	KEY_RIGHT,
	KEY_B,
	KEY_A
]
var sequence_index = 0

func cheat_code(event):
	if event.type == InputEvent. and event.pressed:
		if event.scancode == sequence[sequence_index]:
			sequence_index += 1
			if sequence_index == sequence.size():
				# Cheat is now active here. Do whatever.
				sequence_index = 0
		else:
			sequence_index = 0
