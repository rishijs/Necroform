extends Area2D

@export_category("refs")
@export var mount_loc:Marker2D

var dmg = 1
var knockback_strength = 1

func _ready():
	pass


func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.hit.emit(dmg,knockback_strength)
	elif body.is_in_group("Awaken"):
		body.hit.emit(dmg,0)
		call_deferred("queue_free")
	elif body.is_in_group("Skeleton"):
		set_collision_mask_value(Globals.col_names.PLAYER,false)
		set_collision_mask_value(Globals.col_names.SKELETON,false)
		body.mount.emit(mount_loc.global_position)
