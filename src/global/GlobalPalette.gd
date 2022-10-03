extends Node
tool
onready var background: Node = $Background
onready var object: Node = $Object

onready var object_palettes := object.get_children()
onready var background_palettes := background.get_children()

onready var palettes = [background_palettes, object_palettes]

func change_palette(type: int, index: int, by: PoolColorArray) -> void:
	pass
func get_palette_material(type: int, index: int) -> Material:
	return palettes[type][index].material

