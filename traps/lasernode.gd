extends Node2D

@onready var player_ref = get_tree().get_first_node_in_group("Player")

@export var angle : float = 0.0
@export var frequency : float = 3.0
@export var start_delay : float = 0.5
@export var room : int = 1

var lasers = preload("res://traps/laser.tscn")

@export_category("refs")
@export var laser_point:Marker2D
@export var timer:Timer

func _ready():
	timer.wait_time = frequency
	await get_tree().create_timer(start_delay,false).timeout
	timer.start()

func fire_laser():
	var laser = lasers.instantiate()
	laser.parent = self
	add_child(laser)
	laser.global_position = global_position
	laser.global_rotation = angle

func _process(_delta):
	pass

func _on_timer_timeout():
	if player_ref.room == room:
		fire_laser()
