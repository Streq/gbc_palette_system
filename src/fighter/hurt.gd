extends FighterState

func _physics_update(delta: float) -> void:
	pass
	
func _on_animation_finished():
	goto("idle")
	pass
