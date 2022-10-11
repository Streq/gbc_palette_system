extends FighterState

export var can_buffer := false
var buffered_jab := false

func _enter(params):
	can_buffer = false
	buffered_jab = false

func _physics_update(delta: float) -> void:
	if root.is_on_floor():
		goto("idle")
		return
	root.velocity.x = sign(root.input_state.dir.x)*root.run_speed
	if can_buffer:
		if root.input_state.B.is_just_pressed():
			buffered_jab = true
func _on_animation_finished():
	if buffered_jab:
		var dir = root.input_state.dir
		if dir.y<0:
			if sign(dir.x) == root.facing_dir:
				goto("uf_air")
			else:
				goto("u_air")
		elif dir.y>0:
			goto("d_air")
		else:
			goto("f_air")
	else:
		goto("air")
	
	pass
