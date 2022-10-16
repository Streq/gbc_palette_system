extends Node

export var active = true

func _ready() -> void:
	if active:
		get_tree().paused = true

var next_frame = false

func _physics_process(delta: float) -> void:
	if active:
		get_tree().paused = !Input.is_key_pressed(KEY_SPACE)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_N:
			get_tree().paused = false
