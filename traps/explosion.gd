extends Node2D

#@export var max_size_explosion = 1.2

#@export_category("refs")
#@export var shape:Polygon2D

var targets = []

func _ready():
	#var tween = get_tree().create_tween()
	#tween.tween_property(shape,"scale",Vector2.ONE*max_size_explosion,0.5)
	print(targets)
	for obj in targets:
		if obj.is_in_group("Player") or obj.is_in_group("Skeleton"):
			obj.hit.emit(1)

func _on_timer_timeout():
	call_deferred("queue_free")
