extends FighterState

func _physics_update(delta: float) -> void:
	if root.is_on_floor():
		goto("idle")
		return
	var dir = root.input_state.dir
	var dirx_unit = sign(dir.x)
	if root.input_state.B.is_just_pressed():
		if dirx_unit == root.facing_dir:
			if dir.y<0:
				goto("uf_air")
			elif dir.y>0:
				goto("df_air")
			else:
				goto("n_air")
		elif dir.y<0:
			goto("u_air")
		elif dir.y>0:
			goto("d_air")
		else:
			goto("n_air")
		return
	
	var _lerp = root.air_run_lerp if dirx_unit else root.air_lerp
	
	root.velocity.x = lerp(root.velocity.x, dirx_unit*root.run_speed, _lerp*delta)
	
