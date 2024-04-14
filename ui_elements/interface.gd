extends CanvasLayer

@onready var player_ref = get_tree().get_first_node_in_group("Player")

@export_category("refs")
@export var health:HBoxContainer
@export var mana:HBoxContainer

func _ready():
	pass


func _process(_delta):
	pass


func _on_timer_timeout():
	for i in range(health.get_children().size()):
		if i < int(player_ref.health):
			health.get_child(i).show()
		else:
			health.get_child(i).hide()

	for i in range(mana.get_children().size()):
		if i < int(player_ref.mana):
			mana.get_child(i).show()
		else:
			mana.get_child(i).hide()
