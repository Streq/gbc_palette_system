extends FighterState

export var friction := 0.1
export var can_buffer := false
var buffered_jab := false

func _enter(params):
	buffered_jab = false
	can_buffer = false

func _physics_update(delta: float) -> void:
	root.velocity.x *= (1.0-friction)
	if can_buffer:
		if root.input_state.B.is_just_pressed():
			buffered_jab = true
func _on_animation_finished():
	if buffered_jab:
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
	else:
		goto("idle")
	pass
