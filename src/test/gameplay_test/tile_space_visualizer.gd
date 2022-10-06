extends Node2D
tool
export var iterations := 5 setget set_iterations
export var color := Color.red setget set_color
export var width := 1.0 setget set_width
onready var size := Vector2(
	ProjectSettings.get("display/window/size/width"),
	ProjectSettings.get("display/window/size/height")
)

func set_size(val):
	size = val
	update()
func set_iterations(val):
	iterations = val
	update()
func set_color(val):
	color = val
	update()
func set_width(val):
	width = val
	update()

func _process(delta: float) -> void:
	update()

func _draw() -> void:
	var pos = to_local(get_global_mouse_position()-size*0.5).snapped(size)
	draw_rect(Rect2(pos, size), color, false, width, false)
	for i in range(-iterations,iterations+1):
		for j in range(-iterations,iterations+1):
			draw_rect(Rect2(pos+Vector2(i*size.x,j*size.y), size), color, false, width, false)
	
func _ready() -> void:
	if !Engine.editor_hint:
		queue_free()
