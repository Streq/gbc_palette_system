extends KinematicBody2D
signal free_from_trap()
signal thrown()
signal grabbed(by)
signal collision(collision)

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
onready var carry_pivot: Node2D = $pivot/carry_pivot



export var facing_dir = 1.0 setget set_facing_dir
var jabbing = false

func _ready() -> void:
	state_machine.initialize()

var is_on_ceiling = false
var is_on_floor = false
var is_on_wall = false

func is_on_ceiling()->bool:
	return is_on_ceiling
func is_on_floor()->bool:
	return is_on_floor
func is_on_wall()->bool:
	return is_on_wall

const MAX_COLLISIONS = 4
	

func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta
	
#	velocity = move_and_slide(velocity, Vector2.UP)
#	print(global_position)
	is_on_floor = false
	is_on_ceiling = false
	is_on_wall = false

	var col_count = 0
	var motion = velocity*delta
#	print(global_position)
	while col_count < MAX_COLLISIONS and !motion.is_equal_approx(Vector2.ZERO):
		var collision = move_and_collide(motion)
		if !collision:
			break
		col_count+=1
		emit_signal("collision", collision)
		if collision.normal.y<0:
			is_on_floor = true
		elif collision.normal.y>0:
			is_on_ceiling = true
		if collision.normal.x:
			is_on_wall = true
		print(collision.remainder)
		velocity = velocity.slide(collision.normal)
		motion = collision.remainder

	
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

func _on_dropped_by_carrier():
	_on_free_from_trap()

func _on_thrown_by_carrier(velocity:Vector2):
	self.velocity = velocity
	state_machine.call_deferred("_change_state","launch",[])
	emit_signal("thrown")
func _on_grabbed_by_carrier(carrier):
	self.velocity = Vector2()
	state_machine.call_deferred("_change_state","trapped",[])
	emit_signal("grabbed", carrier)


func _on_free_from_trap():
	emit_signal("free_from_trap")
	
