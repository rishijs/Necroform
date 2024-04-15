extends Node2D

enum hint_types {L1_1,L2_1,L2_2,L2_3,L3_1,L3_2,L3_3,L3_4,L4_1}
@export var hint: hint_types

var hint_text = {
	"ITS SUMMONING TIME" = "Press Q/LeftClick/1 or Joystick to Summon Skeletons",
	
	"SKELETON UTILITY!!" = "You Can Jump on Skeletons If you are Fast Enough",
	"REMEMBER LAST LEVEL" = "Use Skeletons to Cover The Spikes",
	"SOME ACTION FINALLY" = "Spawn Skeletons to Defeat Guards, Is There Other Way? (No)",
	
	"HIDDEN MINES" = "Press E/RightClick/2 or Joystick to Summon The Dark Star",
	"LONG WAY UP" = "Now that's A Long Way Up",
	"LASER LIGHT SHOW" = "So Many Lasers go PewPew!",
	"AWAKENED SKELETON" = "Press R to Awaken. Mana Does Not Regenerate. You Lose Max Mana Everytime.",
	
	"AWAKENED DARKSTAR" = "For the Finale: Use the Awakened Dark Star and Clear all the Mines! Also Full Heals!",
}

func _ready():
	pass


func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().get_first_node_in_group("Interface").hint_triggered.emit(hint_text.keys()[hint],
																			hint_text[hint_text.keys()[hint]])
