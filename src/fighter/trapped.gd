extends FighterState

func _enter(params):
	root.set_physics_process(false)
	root.connect("free_from_trap",self,"_on_free_from_trap")

func _exit():
	root.set_physics_process(true)
	root.disconnect("free_from_trap",self,"_on_free_from_trap")

func _on_free_from_trap():
	goto("air")

func _physics_update(delta: float) -> void:
	pass
	
func _on_animation_finished():
#	goto("idle")
	pass
