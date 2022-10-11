extends Area2D
signal hitbox(hitbox)

func _on_hitbox_entered(area: Area2D):
	emit_signal("hitbox",area)
