extends CharacterBody2D

@onready var player_ref = get_tree().get_first_node_in_group("Player")

var speed = 250.0
var hover_height = 100
var health = 1

signal hit(damage)

@export_category("refs")
@export var timer:Timer

func _ready():
	pass
	
func _physics_process(delta):
	velocity.x = speed
	move_and_slide()

func _on_timer_timeout():
	call_deferred("queue_free")


func _on_reveal_body_entered(body):
	pass


func _on_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
	
