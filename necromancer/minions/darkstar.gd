extends CharacterBody2D

@onready var player_ref = get_tree().get_first_node_in_group("Player")

var speed = 250.0
var hover_height = 100
var health = 1
var damage = 0
var dir = 1
var speedboost = 1.25

signal hit(damage,knockback)

@export_category("refs")
@export var timer:Timer

func _ready():
	player_ref.speed *= speedboost
	
func _physics_process(_delta):
	velocity.x = speed
	move_and_slide()

func destruct():
	player_ref.speed /= speedboost
	call_deferred("queue_free")

func _on_timer_timeout():
	destruct()


func _on_hit(damage,knockback):
	health -= damage
	if health <= 0:
		destruct()
	


func _on_reveal_area_entered(area):
	if area.is_in_group("Mine"):
		area.show()
