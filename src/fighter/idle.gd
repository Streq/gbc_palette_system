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
		var dir = root.input_state.dir
		if dir.x:
			root.facing_dir = sign(dir.x)
		if dir.y<0:
			if sign(dir.x) == root.facing_dir:
				goto("uppercut")
			else:
				goto("u_tilt")
		else:
			goto("jab")
	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
	
