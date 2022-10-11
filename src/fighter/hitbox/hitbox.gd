extends Area2D



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner != owner:
		area._on_hitbox_entered(self)
