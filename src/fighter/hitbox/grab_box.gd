extends Area2D
signal success(grabbed)

var succeeded = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if !succeeded:
		if area.owner != owner and area.owner.team != owner.team:
			area._on_grabbox_entered(self)

func _on_success(grabbed):
	succeeded = true
	emit_signal("success", grabbed)
	call_deferred("set","succeeded",false)
	pass
