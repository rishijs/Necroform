extends CharacterBody2D


var speed = 200.0
var health = 1
var mounted = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal mount(loc)
signal hit(damage)

func _ready():
	pass
	
func _physics_process(delta):
	if not mounted:
		if not is_on_floor():
			velocity.y += gravity * delta

		velocity.x = speed
		move_and_slide()

func _on_timer_timeout():
	if not mounted:
		call_deferred("queue_free")

func _on_mount(loc):
	mounted = true
	global_position = loc
	scale *= 1.5
	set_collision_mask_value(Globals.col_names.DECAY,true)
	set_collision_mask_value(Globals.col_names.SKELETON,false)
	set_collision_mask_value(Globals.col_names.ENEMY,false)


func _on_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
