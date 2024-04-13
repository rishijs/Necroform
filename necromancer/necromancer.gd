extends CharacterBody2D

@onready var obj_pool = get_tree().get_first_node_in_group("Objects")

var max_health = 2
var health = 2
var speed = 150.0
var jump_vel = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var rooted = false
enum dirs {LEFT,RIGHT}
var dir = dirs.RIGHT

signal hit(damage)

enum minions {SKELETON,DARKSTAR}
var awakened = false
var skeletons = preload("res://necromancer/minions/skeleton.tscn")
var darkstars = preload("res://necromancer/minions/darkstar.tscn")

@export_category("ref")
@export var sprite:Sprite2D
@export var spawn_l:Marker2D
@export var spawn_r:Marker2D


func _input(_event):
	if Input.is_action_just_pressed("summon1"):
		spawn_minion(minions.SKELETON,3)
	if Input.is_action_just_pressed("summon2"):
		spawn_minion(minions.DARKSTAR,1)
	if Input.is_action_just_pressed("left") and not rooted:
		dir = dirs.LEFT
		sprite.flip_h = true
	if Input.is_action_just_pressed("right") and not rooted:
		dir = dirs.RIGHT
		sprite.flip_h = false

func spawn_minion(type,n):
	rooted = true
	for i in range(n):
		match type:
			minions.SKELETON:
				await get_tree().create_timer(0.25,false).timeout
				spawn_skeleton()
			minions.DARKSTAR:
				await get_tree().create_timer(0.25,false).timeout
				spawn_darkstar()
	rooted = false

func spawn_skeleton():
	var skeleton = skeletons.instantiate()
	
	if dir == dirs.LEFT:
		skeleton.speed *= -1
		obj_pool.add_child(skeleton)
		skeleton.global_position = spawn_l.global_position
	elif dir == dirs.RIGHT:
		obj_pool.add_child(skeleton)
		skeleton.global_position = spawn_r.global_position

func spawn_darkstar():
	var darkstar = darkstars.instantiate()
	
	if dir == dirs.LEFT:
		darkstar.speed *= -1
		obj_pool.add_child(darkstar)
		darkstar.global_position = spawn_l.global_position
	elif dir == dirs.RIGHT:
		obj_pool.add_child(darkstar)
		darkstar.global_position = spawn_r.global_position
	
	
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
