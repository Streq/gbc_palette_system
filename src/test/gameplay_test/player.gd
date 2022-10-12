extends KinematicBody2D
export var velocity := Vector2()

export var walk_speed := 60.0
export var run_speed := 160.0
export var gravity := 150.0
export var jump_speed := 125.0
export var team := 0
export (float, 0, 60) var idle_lerp := 0
export (float, 0, 60) var stop_lerp := 0
export (float, 0, 60) var run_lerp := 0
export (float, 0, 60) var air_lerp := 0
export (float, 0, 60) var air_run_lerp := 0



onready var input_state: Node = $input_state
onready var state_animation: AnimationPlayer = $state_animation
onready var pivot: Node2D = $pivot
onready var state_machine: Node = $state_machine



export var facing_dir = 1.0 setget set_facing_dir
var jabbing = false

func _ready() -> void:
	state_machine.initialize()

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	state_machine.physics_update(delta)
	
	#esto no va mas
	return
	velocity.x = input_state.dir.x * walk_speed
	if jabbing:
		return
	if is_on_floor():
		if velocity.x:
			state_animation.play("walk")
		else:
			state_animation.play("idle")
	else:
		state_animation.play("air")
	
	var dir = input_state.dir
	if dir.x and sign(dir.x) != facing_dir and is_on_floor():
		set_facing_dir(dir.x)
	
	if input_state.A.is_just_pressed() and is_on_floor():
		velocity.y -= jump_speed


	if input_state.B.is_just_pressed():
		
		if dir.y<0.0:
			state_animation.play("u_tilt")
		elif dir.y>0.0 and !is_on_floor():
			state_animation.play("d_air")
		else:
			state_animation.play("jab")
			
		jabbing = true
		yield(state_animation,"animation_finished")
		jabbing = false
	

func turn_around():
	set_facing_dir(sign(-facing_dir))

func set_facing_dir(val):
	facing_dir = val
	pivot.scale.x = sign(facing_dir)*abs(pivot.scale.x)
