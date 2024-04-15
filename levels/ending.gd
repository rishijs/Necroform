extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func _on_next_pressed():
	get_tree().change_scene_to_file("res://ui_elements/main_menu.tscn")
