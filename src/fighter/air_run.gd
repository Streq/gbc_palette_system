extends FighterState

func _physics_update(delta: float) -> void:
	if root.is_on_floor():
		goto("idle")
	
	root.velocity.x = root.input_state.dir.x*root.run_speed
	
