extends Sprite


func _physics_process(delta: float) -> void:
	position += Input.get_vector("ui_left","ui_right","ui_up","ui_down")*delta*100.0
