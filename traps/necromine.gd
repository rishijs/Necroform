extends Area2D

@onready var obj_pool = get_tree().get_first_node_in_group("Objects")

var explosions = preload("res://traps/explosion.tscn")

func _ready():
	pass


func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Skeleton"):
		explode()

func explode():
	await get_tree().create_timer(0.25,false).timeout
	var explosion = explosions.instantiate()
	for obj in get_overlapping_bodies():
		if obj.is_in_group("Player") or obj.is_in_group("Skeleton"):
			explosion.targets.append(obj)
	obj_pool.add_child(explosion)
	explosion.global_position = global_position
	call_deferred("queue_free")
