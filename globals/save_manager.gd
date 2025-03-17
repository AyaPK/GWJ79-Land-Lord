extends Node

func create_package(_node:Node)->PackedScene:
	_set_owner(_node, _node)
	var package: = PackedScene.new()
# warning-ignore:return_value_discarded
	package.pack(_node)
	return package

func _set_owner(_node:Node, _owner:Node)->void:
	for child in _node.get_children():
		child.owner = _owner
		_set_owner(child, _owner)
