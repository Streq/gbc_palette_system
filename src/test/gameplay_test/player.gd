extends KinematicBody2D

export var velocity := Vector2()

export var walk_speed := 144.0
export var gravity := 150.0
export var jump_speed := 125.0

func _physics_process(delta: float) -> void:
	
	velocity.x = Input.get_axis("ui_left","ui_right")*walk_speed
	velocity.y += gravity*delta
	
	if Input.is_action_just_pressed("A") and is_on_floor():
		velocity.y -= jump_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
