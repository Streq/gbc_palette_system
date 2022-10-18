extends FighterState


func _physics_update(delta: float) -> void:
	root.velocity.x = lerp(root.velocity.x, 0.0, root.idle_lerp*delta)

	if !root.is_on_floor():
		goto("air")
		return
	var dir = root.input_state.dir
	var dir_x = sign(dir.x)
	if dir_x and dir_x != root.facing_dir:
		root.turn_around()
	
	if root.input_state.B.is_just_pressed():
		if root.input_state.A.is_just_pressed():
			goto("grab")
		elif dir.y<0:
			if dir_x == root.facing_dir:
				goto("uf_tilt")
			else:
				goto("u_tilt")
		else:
			goto("jab")
		return

	if root.input_state.A.is_just_pressed():
		goto("jump")
		return
	
	if root.input_state.dir.x:
		goto("run")
		return
	
