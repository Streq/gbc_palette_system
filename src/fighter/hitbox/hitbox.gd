extends Area2D

export var knockback := Vector2()
export var damage := 0.0

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner != owner and area.owner.team != owner.team:
		area._on_hitbox_entered(self)

func get_knockback():
	return Vector2(knockback.x*owner.facing_dir, knockback.y)
