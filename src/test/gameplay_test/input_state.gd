extends Node
class_name InputState
var A := ButtonState.new()
var B := ButtonState.new()
var dir := Vector2()

func stale():
	A.stale()
	B.stale()

func _physics_process(delta: float) -> void:
	stale()
