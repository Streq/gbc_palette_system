extends Node2D

export var speed := 200
export var damp := 2.5


var velocity := Vector2()
func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	look_at(player.global_position)
	velocity += global_position.direction_to(player.global_position)*speed*delta
	velocity *= (1.0 - damp*delta)
	global_position += velocity*delta
	


func _on_hurtbox_area_entered(area: Area2D) -> void:
	queue_free()
