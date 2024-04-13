extends CharacterBody2D

var max_health = 1
var health = 1
var speed = 150.0
var jump_vel = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var rooted = false
enum dirs {LEFT,RIGHT}
var dir = dirs.RIGHT

signal hit(damage)

var skeletons = preload("res://necromancer/minions/skeleton.tscn")

@export_category("ref")
@export var spawn_l:Marker2D
@export var spawn_r:Marker2D
@export var objects_pool:Node


func _input(_event):
	if Input.is_action_just_pressed("summon"):
		spawn_minion(3)
	if Input.is_action_just_pressed("left"):
		dir = dirs.LEFT
	if Input.is_action_just_pressed("right"):
		dir = dirs.RIGHT

func spawn_minion(n):
	rooted = true
	for i in range(n):
		await get_tree().create_timer(0.25,false).timeout
		spawn_skeleton()
	rooted = false

func spawn_skeleton():
	var skeleton = skeletons.instantiate()
	
	if dir == dirs.LEFT:
		skeleton.speed *= -1
		objects_pool.add_child(skeleton)
		skeleton.global_position = spawn_l.global_position
	elif dir == dirs.RIGHT:
		objects_pool.add_child(skeleton)
		skeleton.global_position = spawn_r.global_position
	
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel

	var direction = Input.get_axis("left", "right")
	if direction and not rooted:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_hit(damage):
	health -= damage
	if health <= 0:
		get_tree().reload_current_scene()
