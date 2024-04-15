extends CanvasLayer

@onready var player_ref = get_tree().get_first_node_in_group("Player")

@export_category("refs")
@export var health1:TextureRect
@export var health2:TextureRect
@export var mana:HBoxContainer
@export var mana_progress:ProgressBar

func _input(_event):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(_delta):
	pass


func _on_timer_timeout():
	mana_progress.value = floor(player_ref.mana)
	
	if int(player_ref.health) == 1:
		health1.show()
		health2.hide()
	elif int(player_ref.health) == 2:
		health1.show()
		health2.show()

	for i in range(mana.get_children().size()):
		if i < int(player_ref.mana):
			mana.get_child(i).show()
		else:
			mana.get_child(i).hide()


func _on_restart_pressed():
	get_tree().reload_current_scene()
