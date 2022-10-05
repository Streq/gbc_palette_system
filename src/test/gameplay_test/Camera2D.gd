extends Camera2D
tool
const SCREEN_SIZE = Vector2(256,144)

func _physics_process(delta: float) -> void:
	var parent_pos = get_parent().global_position
	
	global_position = (parent_pos-SCREEN_SIZE*0.5).snapped(SCREEN_SIZE)
	print(global_position)
