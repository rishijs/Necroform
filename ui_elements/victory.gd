extends CanvasLayer

@export var level_index = 0

var levels = [
	preload("res://levels/levels/level1.tscn"),
	#preload("res://levels/levels/level2.tscn"),
	#preload("res://levels/levels/level3.tscn"),
	#preload("res://levels/levels/level4.tscn"),
	#preload("res://levels/levels/level5.tscn"),
	#preload("res://levels/levels/level6.tscn"),
	#preload("res://levels/levels/level7.tscn"),
	#preload("res://levels/levels/level8.tscn")
]

func _ready():
	pass


func _process(delta):
	pass


func _on_next_pressed():
	get_tree().change_scene_to_file(levels[level_index])
