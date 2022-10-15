extends FighterState

export var friction := 0.1
#export var can_buffer := false
#var buffered_jab := false

func _enter(params):
#	buffered_jab = false
#	can_buffer = false
	pass

func _physics_update(delta: float) -> void:
	var dirx_unit = sign(root.input_state.dir.x)
	var _lerp = root.air_run_lerp if dirx_unit else root.air_lerp
	root.velocity.x = lerp(root.velocity.x, dirx_unit*root.run_speed, _lerp*delta)
	
func _on_animation_finished():
	goto("air")

func throw():
	var dir = root.input_state.dir
	var vec = Vector2(300.0*root.facing_dir, -0.0)
	if dir:
		vec = vec.rotated(dir.angle())*root.facing_dir
	root.carry_pivot.throw_carried_object(vec)
