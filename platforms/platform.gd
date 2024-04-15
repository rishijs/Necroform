extends RigidBody2D

@export var bottom_start = true
var speed = 100

@export_category("refs")
@export var bottom:Marker2D
@export var top:Marker2D

func _ready():
	pass

func _physics_process(_delta):
	if bottom_start:
		linear_velocity.y = speed * bottom.global_position.direction_to(top.global_position).y
		if global_position.y <= top.global_position.y:
			linear_velocity = Vector2.ZERO
			bottom_start = false
	elif not bottom_start:
		linear_velocity.y = speed * top.global_position.direction_to(bottom.global_position).y
		if global_position.y >= bottom.global_position.y:
			linear_velocity = Vector2.ZERO
			bottom_start = true
	

func _process(_delta):
	pass
