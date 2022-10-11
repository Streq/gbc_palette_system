extends Node2D
tool

export var monitoring := false setget set_monitoring
export var monitorable := false setget set_monitorable
export var enabled := false setget set_enabled

func set_monitoring(val):
	monitoring = val
	for child in get_children():
		child.monitoring = val && enabled

func set_monitorable(val):
	monitorable = val
	for child in get_children():
		child.monitorable = val && enabled

func set_enabled(val):
	enabled = val
	for child in get_children():
		child.monitorable = monitorable && enabled
		child.monitoring = monitoring && enabled
	visible = enabled
