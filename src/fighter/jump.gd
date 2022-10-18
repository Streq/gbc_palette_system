extends FighterState


func _physics_update(delta: float) -> void:
	root.velocity.x = lerp(root.velocity.x, 0.0, root.idle_lerp*delta)
	if root.input_state.B.is_just_pressed():
		goto("grab")

func _on_animation_finished() -> void:
	root.velocity.y -= root.jump_speed
	goto("air")
