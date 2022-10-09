extends FighterState

func _physics_update(delta: float) -> void:
	if root.is_on_floor():
		goto("idle")
		return
	if root.input_state.B.is_just_pressed():
		var dir = root.input_state.dir
		if dir.y>0:
			goto("d_air")
		elif dir.y<0:
			goto("u_air")
		else:
			goto("f_air")
		return
	
	root.velocity.x = sign(root.input_state.dir.x)*root.run_speed
	
