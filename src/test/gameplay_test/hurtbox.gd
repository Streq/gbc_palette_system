extends Area2D

onready var animation: AnimationPlayer = $"../../animation"

func _on_hitbox_entered(area:Area2D):
	owner.velocity = area.get_knockback()
	animation.play("hurt")

func _on_grabbox_entered(area:Area2D):
	pass
