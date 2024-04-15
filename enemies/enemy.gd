extends CharacterBody2D


var patrol_speed = 25.0
var speed = 200.0
var health = 5
var dmg = 1
var knockback_strength = 1
#var target_detected = false
var patrol_mode = true
var targets = []
var target = null
var dir = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal hit(damage,knockback)

@export_category("refs")
@export var patrol_range:Area2D
@export var patrol_left:Marker2D
@export var patrol_right:Marker2D
@export var sprite:AnimatedSprite2D
@export var health_text:Label

func _ready():
	sprite.play("walking")
	health_text.text = str(health)
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if target != null and self in patrol_range.get_overlapping_bodies():
		velocity.x = global_position.direction_to(target.global_position).x * speed
	
	elif patrol_mode == true:
		if dir == 1:
			if global_position.x < patrol_right.global_position.x:
				velocity.x = 1.0 * speed
			else:
				dir = 0
		elif dir == 0:
			if global_position.x > patrol_left.global_position.x:
				velocity.x = -1.0 * speed
			else:
				dir = 1
	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		switch_to_patrol_mode()
		

	move_and_slide()

func attack():
	for possible_target in targets:
		if possible_target.is_in_group("Skeleton"):
			target = possible_target
	
	if target == null and patrol_mode == false:
		sprite.play("idle")
		
	if target == null:
		for possible_target in targets:
			if possible_target.is_in_group("Player"):
				target = possible_target
		
	if target != null:
		await get_tree().create_timer(0.25,false).timeout
		if target != null:
			sprite.play("attack")
			%attack.play()
			target.hit.emit(dmg,knockback_strength)
			if target.health > 0:
				await get_tree().create_timer(1,false).timeout
				if targets.size() > 0:
					attack()
		
func switch_to_patrol_mode():
	if patrol_mode == false and target == null:
		await get_tree().create_timer(3,false).timeout
		if target == null:
			sprite.play("walking")
			patrol_mode = true
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Skeleton"):
		targets.append(body)
		patrol_mode = false
		attack()
	elif body.is_in_group("Player"):
		targets.append(body)
		patrol_mode = false
		attack()

func _on_area_2d_body_exited(body):
	if body in targets:
		targets.erase(body)


func _on_hit(damage,knockback):
	health -= damage
	health_text.text = str(health)
	apply_knockback(knockback)
	if health <= 0:
		queue_free()

func apply_knockback(strength):
	var change : Vector2
	if dir == 1:
		change = Vector2(-strength * 2 * 30.0,-strength * 30.0)
	elif dir == 0:
		change = Vector2(strength * 2 * 30.0,-strength * 30.0)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",global_position+change,0.1)
