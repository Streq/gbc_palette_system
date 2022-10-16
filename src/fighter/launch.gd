extends FighterState
func _enter(params):
#	root.set_physics_process(false)
#	root.connect("free_from_trap",self,"_on_free_from_trap")
	pass
func _exit():
#	root.set_physics_process(true)
#	root.disconnect("free_from_trap",self,"_on_free_from_trap")
	pass

func _physics_update(delta: float) -> void:
	if root.velocity.length_squared() <= 100.0*100.0: 
		goto("air")
		
func _on_animation_finished():
#	goto("idle")
	pass
const MAX_COLLISIONS = 1
func _move(delta):
#	print(global_position)
	var is_on_floor = false
	var is_on_ceiling = false
	var is_on_wall = false

	var col_count = 0
	var motion = root.velocity*delta
#	print(global_position)
	while col_count < MAX_COLLISIONS and !motion.is_equal_approx(Vector2.ZERO):
		var collision: KinematicCollision2D = root.move_and_collide(motion)
		if !collision:
			break
		col_count+=1
		_on_collision(collision)
		if collision.normal.y<0:
			is_on_floor = true
		elif collision.normal.y>0:
			is_on_ceiling = true
		if collision.normal.x:
			is_on_wall = true
#		print(collision.remainder)
#		root.palette_animation.play("hurt")
#		root.state_machine._change_state("hurt",[])
		
		
		root.velocity = root.velocity.bounce(collision.normal)*0.6
		motion = collision.remainder

func _on_collision(collision):
	root.take_damage(10.0)
	goto("hurt")
