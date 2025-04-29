class_name ActionSet
extends Node

@export var actionset_display_name : String = "UntitledActionSet"

@onready var Battle : BattleScene = get_tree().current_scene

var actions = {}

func create_action(id : String, display : String, desc : String,  spr : Texture2D, cost : int, can_call : bool, call : Callable, meta := {}):
	var new_action = {
		"display" : display,
		"desc" : desc,
		"spr" : spr,
		"cost" : cost,
		"can_call" : can_call,
		"func" : call,
	}
	
	for k in meta.keys():
		new_action[k] = meta[k]
	
	actions[id] = new_action

func set_action_prop(action_id : String, action_prop : String, value):
	actions[action_id][action_prop] = value

func get_action_prop(action_id : String, action_prop):
	return actions[action_id][action_prop]

func get_actions():
	return actions
