extends Node2D

onready var carried = get_child(0) if get_child_count() else null


func drop_carried_object():
	if is_instance_valid(carried) and carried.is_inside_tree():
		NodeUtils.reparent_keep_transform(carried, owner.get_parent())
		carried._on_dropped_by_carrier()
		carried = null
