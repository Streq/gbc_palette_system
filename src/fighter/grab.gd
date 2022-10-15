extends FighterState

export var friction := 0.1
var grabbed = null

func _enter(params):
	grabbed = null
	
	pass
func _physics_update(delta: float) -> void:
	root.velocity.x = lerp(root.velocity.x, 0.0, root.stop_lerp*delta)

func _on_success(grabbed):
	self.grabbed = grabbed
	owner.carry_pivot.call_deferred("carry", grabbed)

func _on_animation_finished():
	if is_instance_valid(grabbed) and grabbed.is_inside_tree():
		goto("carry_idle")
	else:
		goto("idle")
