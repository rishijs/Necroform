extends Node2D

#@export var max_size_explosion = 1.2

#@export_category("refs")
#@export var shape:Polygon2D
var dmg = 1
var knockback_strength = 1
var targets = []

func _ready():
	#var tween = get_tree().create_tween()
	#tween.tween_property(shape,"scale",Vector2.ONE*max_size_explosion,0.5)
	for obj in targets:
		if obj.is_in_group("Player"):
			obj.hit.emit(dmg,knockback_strength)
		if obj.is_in_group("Skeleton"):
			if not obj.mounted:
				obj.hit.emit(dmg,knockback_strength)

func _on_timer_timeout():
	call_deferred("queue_free")
