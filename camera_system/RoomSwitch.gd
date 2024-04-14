extends Area2D

@onready var camera_manager_ref = get_tree().get_first_node_in_group("CameraManager")
@onready var player_ref = get_tree().get_first_node_in_group("Player")

@export var room_number:int

func _ready():
	pass


func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_ref.room = room_number
		Globals.player_room_number = room_number
		camera_manager_ref.get_child(room_number).make_current()
		for laser in get_tree().get_nodes_in_group("Laser"):
			laser.hide()
