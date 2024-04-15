extends Area2D

@export_category("refs")
@export var victory_screen:CanvasLayer

func _ready():
	pass


func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		victory_screen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().get_first_node_in_group("GameMusic").stop()
		%level_complete.play()
