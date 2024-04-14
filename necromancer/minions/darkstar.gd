extends CharacterBody2D

@onready var player_ref = get_tree().get_first_node_in_group("Player")

var speed = 250.0
var hover_height = 100
var health = 1
var dmg = 0
var dir = 1
var awaken = false
var speedboost = 1.25

signal hit(damage,knockback)

@export_category("refs")
@export var timer:Timer

func _ready():
	player_ref.speed *= speedboost
	if awaken:
		upgrade()

func _physics_process(_delta):
	velocity.x = speed
	move_and_slide()

func upgrade():
	scale *= 2
	player_ref.speed *= 1.2
	player_ref.health = player_ref.max_health
	
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
		if awaken:
			area.explode()
	if awaken:
		if area.is_in_group("Laser"):
			area.parent.frequency *= 2
			area.queue_free()
			
		
