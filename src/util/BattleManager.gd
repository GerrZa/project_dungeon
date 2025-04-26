extends Node2D

var plr_max_hp = 100
@export var plr_hp = plr_max_hp

var ene_max_hp = 100
@export var ene_hp = ene_max_hp

var ene_action_deck = {
	
}

var plr_action_deck = {
	"sword_ready": {
		"display_name" : "Sword Ready",
		"can_call" : true,
		"callable" : func(): 
	}
}

var action_choose = []

func start_battle():
	pass

func end_battle():
	pass

func set_deck_prop(side : String, item_name : String, prop_name : String, value):
	match side:
		"player":
			plr_action_deck[item_name][prop_name] = value
		"enemy":
			ene_action_deck[item_name][prop_name] = value
			
