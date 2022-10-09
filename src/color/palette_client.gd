extends Node
tool
onready var GlobalPalette := get_node("/root/GlobalPalette")

enum TYPE {
	BACKGROUND,
	OBJECT
}

export (TYPE) var type : int setget set_type
export (int, 0, 7) var index : int setget set_index
export var trigger := false setget set_trigger

func set_trigger(val):
	update_parent_material()


func set_index(val):
	index = val
	if is_inside_tree():
		update_parent_material()
	pass

func set_type(val):
	type = val
	if is_inside_tree():
		update_parent_material()
	pass

func _ready() -> void:
	update_parent_material()

func update_parent_material():
	var parent = get_parent()
	if "material" in parent:
		parent.material = GlobalPalette.get_palette_material(type, index)

