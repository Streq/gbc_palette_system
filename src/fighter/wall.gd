extends FighterState

const WALL_UNGLUE_TIME = 0.05

var wall_unglue_timer = 0.0


func _enter(params):
	wall_unglue_timer = 0.0
	root.turn_around()


func _physics_update(delta: float) -> void:
	root.velocity.x = -root.facing_dir*10.0
	if root.is_on_floor():
		root.turn_around()
		goto("idle")
		return
	if !root.is_on_wall():
		root.turn_around()
		goto("air")
		return
	
	var dir = root.input_state.dir
	var dir_x = sign(dir.x)
	
	if dir_x == root.facing_dir:
		wall_unglue_timer+=delta
		if wall_unglue_timer>=WALL_UNGLUE_TIME:
			goto("air")
			return
		
	else:
		wall_unglue_timer = 0.0
		
	if root.input_state.A.is_just_pressed():
		root.velocity.y += -root.jump_speed*0.8*0.707107
		root.velocity.x += root.jump_speed*0.8*0.707107*root.facing_dir
		goto("air")
		return
	
	root.velocity.y = lerp(root.velocity.y, 0.0, 1.0*delta)
	
func _move(delta):
	root.velocity = root.move_and_slide(root.velocity+Vector2(-root.facing_dir,0.0)*delta, Vector2.UP)

	
	
