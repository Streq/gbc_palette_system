extends FighterState



func _physics_update(delta: float) -> void:
	if !root.is_on_floor():
		goto("carry_air")
		return
	var dir = root.input_state.dir
	var dir_x = sign(dir.x)
	
	if dir_x and dir_x != root.facing_dir:
		root.turn_around()
	
	if root.input_state.B.is_just_pressed():
		if dir.y<0:
			if dir_x == root.facing_dir:
				goto("throw")
				pass
			else:
				goto("throw")
				pass
		else:
			goto("throw")
			pass
		return
	if !dir_x:
		goto("carry_idle")
		return
	
	root.velocity.x = lerp(root.velocity.x, root.facing_dir*root.run_speed, root.run_lerp*delta)
	
	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
	
