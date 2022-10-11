extends Area2D


func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		var dir = global_position.direction_to(area.owner.global_position)
		area.owner.velocity += dir * 100.0 * delta
