extends CanvasLayer

@onready var player_ref = get_tree().get_first_node_in_group("Player")

@export_category("refs")
@export var awaken:ColorRect
@export var noise:ColorRect

func _input(_event):
	if Input.is_action_just_pressed("awaken"):
		if awaken.visible:
			awaken.hide()
		else:
			awaken.show()
		
func _ready():
	pass


func _process(_delta):
	#if abs(player_ref.velocity.x) > 0:
	#	noise.material.set_shader_parameter("speed",0.1)
	#else:
	#	noise.material.set_shader_parameter("speed",0.01)
	pass
