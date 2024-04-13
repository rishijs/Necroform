extends CharacterBody2D


var speed = 200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed
	move_and_slide()


func _on_timer_timeout():
	call_deferred("queue_free")
