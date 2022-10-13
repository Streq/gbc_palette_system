extends FighterState

func _enter(params):
	root.carry_pivot.drop_carried_object()

func _physics_update(delta: float) -> void:
	pass
	
func _on_animation_finished():
	goto("idle")
	pass
