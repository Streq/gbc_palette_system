extends Node

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("exit"):
		get_tree().quit()
	if event.is_action_pressed("fullscreen"):
		change_fullscreen()
	if event.is_action_pressed("restart") and OS.is_debug_build():
		get_tree().reload_current_scene()

func change_fullscreen():
	var current_screen = OS.current_screen
	OS.set_deferred("window_fullscreen", !OS.window_fullscreen)
	#due to bug
	for i in 3:
		yield(get_tree(),"idle_frame")
		OS.current_screen = current_screen

func _ready() -> void:
	OS.min_window_size=Vector2(
		ProjectSettings.get("display/window/size/width"),
		ProjectSettings.get("display/window/size/height")
	)
