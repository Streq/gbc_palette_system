extends Area2D


func _on_hitbox_entered(area:Area2D):
	owner.queue_free()
