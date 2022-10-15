extends Area2D
signal hitbox(hitbox)
signal grabbox(grabbox)


func _on_hitbox_entered(area: Area2D):
	emit_signal("hitbox", area)

func _on_grabbox_entered(area: Area2D):
	emit_signal("grabbox", area)
