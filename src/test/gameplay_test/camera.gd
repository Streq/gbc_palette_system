extends Camera2D


func _physics_process(delta: float) -> void:
#	offset = global_position-global_position.floor()
	global_position = get_parent().global_position.round()
	pass
