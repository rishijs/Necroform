extends Area2D

var parent = null
var active = false
var dmg = 1
var knockback_strength = 1

@export_category("refs")
@export var timer:Timer
@export var col:CollisionShape2D
@export var warning:Sprite2D
@export var laser:Sprite2D

func _ready():
	pass

func _process(_delta):
	pass

func destruct():
	call_deferred("queue_free")

func _on_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Minion"):
		body.hit.emit(dmg,knockback_strength)

func activate():
	active = true
	col.set_deferred("disabled",false)
	warning.hide()
	laser.show()
	
	for obj in get_overlapping_bodies():
		if obj.is_in_group("Player") or obj.is_in_group("Minion"):
			obj.hit.emit(dmg,knockback_strength)

func _on_timer_timeout():
	if active:
		destruct()
	else:
		timer.wait_time /= 2
		activate()
