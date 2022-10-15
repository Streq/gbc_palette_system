extends Node2D

onready var carried = get_child(0) if get_child_count() else null

func carry(object):
	if is_instance_valid(object) and object.is_inside_tree():
		NodeUtils.reparent_keep_transform(object, self)
		object.position = Vector2()
		object._on_grabbed_by_carrier(owner)
		carried = object
	

func drop_carried_object():
	if is_instance_valid(carried) and carried.is_inside_tree():
		NodeUtils.reparent_keep_transform(carried, owner.get_parent())
		carried._on_dropped_by_carrier()
		carried = null

func throw_carried_object(velocity:=Vector2()):
	if is_instance_valid(carried) and carried.is_inside_tree():
		NodeUtils.reparent_keep_transform(carried, owner.get_parent())
		carried._on_thrown_by_carrier(velocity)
		carried = null
	
