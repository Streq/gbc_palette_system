extends KinematicBody2D

export var speed := 200
export var damp := 2.5
export var facing_dir := 1.0 setget set_facing_dir
onready var pivot: Node2D = $pivot

export var team := 1
var velocity := Vector2()
func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	if player:
#		look_at(player.global_position)
#		rotation = stepify(rotation,PI*0.5)
		var dir = global_position.direction_to(player.global_position)
		set_facing_dir(dir.x)
		velocity += dir*speed*delta
	velocity *= (1.0 - damp*delta)
	velocity = move_and_slide(velocity)
	

func set_facing_dir(val):
	if val:
		facing_dir = sign(val)
	pivot.scale.x = abs(pivot.scale.x)*facing_dir

func _on_hurtbox_area_entered(area: Area2D) -> void:
	queue_free()
