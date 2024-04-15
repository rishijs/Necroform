extends CanvasLayer

func _input(event):
	%music.play()
	
func _ready():
	await get_tree().create_timer(1,false).timeout
	%music.play()


func _process(_delta):
	pass


func _on_next_pressed():
	get_tree().change_scene_to_file("res://levels/levels/level1.tscn")
