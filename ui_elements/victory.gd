extends CanvasLayer

@export var level_index = 0
@export var flavor = ""
var last_level = 4

var levels = [
	"res://levels/levels/level1.tscn",
	"res://levels/levels/level2.tscn",
	"res://levels/levels/level3.tscn",
	"res://levels/levels/level4.tscn",
]

func _ready():
	%complete.text = "Levels Complete: %d/4" % level_index
	%flavor.text = flavor


func _process(_delta):
	if level_index == 4 and visible:
		get_tree().change_scene_to_file("res://levels/ending.tscn")


func _on_next_pressed():
	get_tree().change_scene_to_file(levels[level_index])
	Globals.player_room_number = 0
