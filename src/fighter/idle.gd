extends State
export var anim := ""

# Initialize the state. E.g. change the animation
func _enter(params):
	owner.animation.play(anim)

# Clean up the state. Reinitialize values like a timer
func _exit():
	return
	
# Awake the state from suspension. E.g. Readd nodes to tree
func _awaken():
	return

# Suspend the state. E.g. Remove nodes
func _suspend():
	return

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	return

# Called during _input
func _handle_input(event: InputEvent):
	return
