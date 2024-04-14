extends CharacterBody2D


var speed = 200.0
var health = 1
var dmg = 1
var dir = 1
var knockback_strength = 1
var mounted = false
var awaken = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal mount(loc)
signal hit(damage,knockback)

func _ready():
	if awaken:
		upgrade()
	
func _physics_process(delta):
	if not mounted:
		if not is_on_floor():
			velocity.y += gravity * delta

		velocity.x = speed
		move_and_slide()

func _on_timer_timeout():
	if not mounted:
		call_deferred("queue_free")

func upgrade():
	speed /= 2
	health = 5
	dmg = 3
	scale *= 2.5
	set_collision_layer_value(Globals.col_names.SKELETON,false)
	set_collision_mask_value(Globals.col_names.TRAP,false)
	set_collision_layer_value(Globals.col_names.AWAKENED_SKELETON,true)
	add_to_group("Awakened")
	
func _on_mount(loc):
	mounted = true
	global_position = loc
	scale *= 1.5
	set_collision_mask_value(Globals.col_names.DECAY,true)
	set_collision_mask_value(Globals.col_names.SKELETON,false)
	set_collision_mask_value(Globals.col_names.ENEMY,false)


func _on_hit(damage,knockback):
	health -= damage
	if health <= 0:
		queue_free()

func attack(body):
	body.hit.emit(dmg,knockback_strength)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		attack(body)
