extends KinematicBody2D
signal free_from_trap()
signal thrown()
signal grabbed(by)
signal damage(amount)


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
onready var palette_animation: AnimationPlayer = $palette_animation


export var facing_dir = 1.0 setget set_facing_dir
var jabbing = false

func _ready() -> void:
	state_machine.initialize()
	

func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta
	state_machine.physics_update(delta)


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


func take_damage(amount):
	palette_animation.stop(true)
	palette_animation.play("hurt")
	emit_signal("damage", amount)
