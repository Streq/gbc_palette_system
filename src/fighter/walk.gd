extends FighterState

func _physics_update(delta: float) -> void:
	if !root.is_on_floor():
		goto("air")
		return
	if !root.input_state.dir.x:
		goto("idle")
		return
	if sign(root.input_state.dir.x) != root.facing_dir:
		root.turn_around()
	root.velocity.x = root.facing_dir*root.walk_speed
	
	if root.input_state.A.is_just_pressed():
		root.velocity.y -= root.jump_speed
