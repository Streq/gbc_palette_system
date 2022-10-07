extends KinematicBody2D
export var velocity := Vector2()

export var walk_speed := 144.0
export var gravity := 150.0
export var jump_speed := 125.0


onready var input_state: Node = $input_state
onready var animation: AnimationPlayer = $animation


func _physics_process(delta: float) -> void:
	
	velocity.x = input_state.dir.x * walk_speed
	velocity.y += gravity*delta
	
	if input_state.A.is_just_pressed() and is_on_floor():
		velocity.y -= jump_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
