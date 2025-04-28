class_name ActionSet
extends Node

@export var actionset_display_name : String = "UntitledActionSet"
@export var actionset_id : String = "untitled_actionset"

@onready var Battle : BattleScene = get_tree().current_scene

var actionset = {}

func create_action(id : String, display : String, desc : String,  spr : Texture2D, cost : int, can_call : bool, call : Callable, meta := {}):
	var new_action = {
		"display" : display,
		"desc" : desc,
		"spr" : spr,
		"cost" : cost,
		"can_call" : can_call,
		"func" : call,
		"meta" : meta
	}
	
	actionset[id] = new_action

func import(caller : Battler = get_parent()):
	var act_set = {
		"display" : actionset_display_name,
		"action" : actionset
	}
	caller.actionset_list[actionset_id] = act_set
