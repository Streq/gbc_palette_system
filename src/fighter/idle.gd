extends FighterState

func _physics_update(delta: float) -> void:
	root.velocity.x = 0.0

	if !root.is_on_floor():
		goto("air")
		return
	if root.input_state.dir.x:
		goto("run")
		return
	if root.input_state.B.is_just_pressed():
		if root.input_state.dir.y<0:
			goto("u_tilt")
		else:
			goto("jab")
		return
	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
	
