extends Area2D

var active = false

@export_category("refs")
@export var timer:Timer
@export var col:CollisionShape2D
@export var mesh:MeshInstance2D

func _ready():
	pass

func _process(delta):
	pass

func destruct():
	call_deferred("queue_free")

func _on_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Minion"):
		body.hit.emit(1)

func activate():
	active = true
	col.set_deferred("disabled",false)
	mesh.modulate = Color(1,0,0,1)
	
	for obj in get_overlapping_bodies():
		if obj.is_in_group("Player") or obj.is_in_group("Minion"):
			obj.hit.emit(1)

func _on_timer_timeout():
	if active:
		destruct()
	else:
		timer.wait_time /= 2
		activate()
