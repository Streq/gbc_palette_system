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
	if root.get_slide_count():
		var collision : KinematicCollision2D = root.get_last_slide_collision()
		var normal = collision.normal
		var velocity = collision.collider_velocity
		
		print(collision.travel)
		print(collision.remainder)
		
		root.velocity = velocity.bounce(normal)
		goto("hurt")
		
func _on_animation_finished():
#	goto("idle")
	pass
