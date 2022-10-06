extends Camera2D
tool
#export var SCREEN_SIZE = Vector2(256,144)
onready var SCREEN_SIZE = Vector2(
	ProjectSettings.get("display/window/size/width"),
	ProjectSettings.get("display/window/size/height")
)

func _physics_process(delta: float) -> void:
	var parent_pos = get_parent().global_position
	global_position = (parent_pos-SCREEN_SIZE*0.5).snapped(SCREEN_SIZE)
