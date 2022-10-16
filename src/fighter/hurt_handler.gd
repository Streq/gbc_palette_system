extends Node
onready var palette_animation: AnimationPlayer = $"../palette_animation"


func _on_damage(amount) -> void:
	palette_animation.stop(true)
	palette_animation.play("hurt")
	

func _on_hitbox(hitbox) -> void:
	palette_animation.stop(true)
	palette_animation.play("hurt")
	owner.state_machine.call_deferred("_change_state","hurt",[])
	owner.set_deferred("velocity",hitbox.get_knockback())

func _on_grabbox(grabbox) -> void:
	owner.state_machine.call_deferred("_change_state","trapped",[])
	grabbox._on_success(owner)
