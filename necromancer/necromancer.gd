extends CharacterBody2D

@onready var obj_pool = get_tree().get_first_node_in_group("Objects")
@onready var camera_manager_ref = get_tree().get_first_node_in_group("CameraManager")
@onready var room_origins_ref = get_tree().get_first_node_in_group("RoomOrigins")

var max_health = 4
var health = 2
var dmg = 0
var speed = 150.0
var jump_vel = -500.0
var base_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = base_gravity

var rooted = false
enum dirs {LEFT,RIGHT}
var dir = dirs.RIGHT

signal hit(damage,knockback)

enum minions {SKELETON,DARKSTAR}
var awaken = false
var can_spawn = true
var max_mana = 10
var mana = 10
var mana_regen = 0.1
var awaken_max_mana_penalty = 1.0
var min_max_mana = 5
var spawn_cooldown = 0.1

var skeletons = preload("res://necromancer/minions/skeleton.tscn")
var skeleton_cost = 3
var skeleton_awaken_cost = 4
var darkstars = preload("res://necromancer/minions/darkstar.tscn")
var darkstar_cost = 2
var darkstar_awaken_cost = 7


var room = 0

@export_category("ref")
@export var sprite:AnimatedSprite2D
@export var spawn_l:Marker2D
@export var spawn_r:Marker2D

func _ready():
	room = Globals.player_room_number
	global_position = room_origins_ref.get_child(room).global_position
	sprite.play("idle")

func _input(_event):
	if not rooted:
		if can_spawn:
			if Input.is_action_just_pressed("summon1"):
				if awaken and mana >= skeleton_awaken_cost:
					spawn_minion(minions.SKELETON,1)
					mana -= skeleton_awaken_cost
				elif not awaken and mana >= skeleton_cost:
					spawn_minion(minions.SKELETON,3)
					mana -= skeleton_awaken_cost
			if Input.is_action_just_pressed("summon2"):
				if awaken and mana >= darkstar_awaken_cost:
					spawn_minion(minions.DARKSTAR,1)
					mana -= darkstar_awaken_cost
				elif not awaken and mana >= darkstar_cost:
					spawn_minion(minions.DARKSTAR,1)
					mana -= darkstar_cost
		if Input.is_action_just_pressed("left"):
			dir = dirs.LEFT
			sprite.flip_h = false
		if Input.is_action_just_pressed("right"):
			dir = dirs.RIGHT
			sprite.flip_h = true
	if Input.is_action_just_pressed("awaken"):
		if awaken == true:
			awaken = false
		else:
			awaken = true
			max_mana = clampf(max_mana-1,min_max_mana,max_mana)
			mana = clampf(mana,0,max_mana)

func spawn_minion(type,n):
	rooted = true
	can_spawn = false
	for i in range(n):
		match type:
			minions.SKELETON:
				await get_tree().create_timer(0.25,false).timeout
				spawn_skeleton()
			minions.DARKSTAR:
				await get_tree().create_timer(0.25,false).timeout
				spawn_darkstar()
	rooted = false
	await get_tree().create_timer(spawn_cooldown,false).timeout
	can_spawn = true

func spawn_skeleton():
	var skeleton = skeletons.instantiate()
	skeleton.dir = dir
	skeleton.awaken = awaken
	
	if dir == dirs.LEFT:
		skeleton.speed *= -1
		obj_pool.add_child(skeleton)
		skeleton.global_position = spawn_l.global_position
	elif dir == dirs.RIGHT:
		obj_pool.add_child(skeleton)
		skeleton.global_position = spawn_r.global_position

func spawn_darkstar():
	var darkstar = darkstars.instantiate()
	darkstar.dir = dir
	darkstar.awaken = awaken
	
	if dir == dirs.LEFT:
		darkstar.speed *= -1
		obj_pool.add_child(darkstar)
		darkstar.global_position = spawn_l.global_position
	elif dir == dirs.RIGHT:
		obj_pool.add_child(darkstar)
		darkstar.global_position = spawn_r.global_position

	
func jump_cut():
	velocity.y /= 2
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
			
	if Input.is_action_just_released("jump"):
		jump_cut()

	var direction = Input.get_axis("left", "right")
	if direction and not rooted:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_hit(damage,knockback):
	health -= damage
	if health <= 0:
		get_tree().reload_current_scene()
	else:
		apply_knockback(knockback)
		screenshake()

func apply_knockback(strength):
	var change : Vector2
	if dir == dirs.RIGHT:
		change = Vector2(-strength * 2 * 20.0,-strength * 20.0)
	elif dir == dirs.LEFT:
		change = Vector2(strength * 2 * 20.0,-strength * 20.0)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",global_position+change,0.1)

		
func screenshake():
	var tween = get_tree().create_tween()
	var offset = Vector2(randf_range(-1,1)*10,0)
	var target = camera_manager_ref.get_child(room).global_position + offset
	tween.tween_property(camera_manager_ref.get_child(room),"global_position",target,0.1)
	await get_tree().create_timer(0.1,false).timeout
	camera_manager_ref.get_child(room).global_position -= offset


func _on_mana_regen_timeout():
	if not awaken:
		mana = clampf(mana+mana_regen,0,max_mana)
