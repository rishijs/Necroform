extends CanvasLayer

@onready var player_ref = get_tree().get_first_node_in_group("Player")

@export_category("refs")
@export var awaken:ColorRect

func _input(event):
	if Input.is_action_just_pressed("awaken"):
		if awaken.visible:
			awaken.hide()
		else:
			awaken.show()
		
func _ready():
	pass


func _process(delta):
	pass
