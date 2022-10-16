extends State
class_name FighterState

signal animation_finished

export var animation := ""
var active = false


func enter(params):
	active = true
	_enter(params)
	var anim = owner.state_animation
	#setup
	anim.connect("animation_finished", self, "on_animation_finished")
	anim.play(animation)
	anim.advance(0)
	
	emit_signal("enter", params)
	emit_signal("entered")
	
	
func on_animation_finished(name):
	if name == animation:
		_on_animation_finished()
		emit_signal("animation_finished")
	

func exit():
	active = false
	var anim = owner.state_animation
	anim.disconnect("animation_finished", self, "on_animation_finished")
	#cleanup
	anim.play("RESET")
	anim.advance(0)
	_exit()
	emit_signal("exited")


func physics_update(delta: float):
	_move(delta)
	_physics_update(delta)
	emit_signal("physics_updated", delta)

#OVERRIDABLE FUNCTIONS

# Initialize the state. E.g. change the animation

func _on_animation_finished():
	return

func _move(delta):
	root.velocity = root.move_and_slide(root.velocity, Vector2.UP)
