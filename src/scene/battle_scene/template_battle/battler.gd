#PLAYER
class_name Battler
extends Node2D

var max_hp = 100
var hp = 100

@onready var Battle : BattleScene = get_parent()

@export var effect_group_path : NodePath
@export var actionset_group_path : NodePath

@onready var effect_group := get_node(effect_group_path)
@onready var actionset_group := get_node(actionset_group_path)

signal died
signal fx_added(effect_id)
signal fx_expired(effect_id)

var hold_action = []

var can_play = false

#SETTER GETTER
#----------------FX
#for UI displaying
func get_fx_list():
	var list = {}
	for i in effect_group.get_children():
		list[String(i.name)] = i.display
	return list

func add_fx(fx : PackedScene, duration : int):
	var fx_ins = fx.instantiate() as Effect
	fx_ins.duration = duration
	effect_group.add_child(fx_ins)

#for UI displaying
func get_actionset_list():
	var list = {} #id : display
	for i in actionset_group.get_children():
		list[String(i.name)] = i.actionset_display_name
	
	return list

#for UI displaying
func get_action_list(actionset_id : String):
	var list = {} #id : display
	for i in actionset_group.get_node(actionset_id).actions.keys():
		list[i] = actionset_group.get_node(actionset_id).actions[i]["display"]
	
	return list

#func add_fx(fx : Dictionary):
	#print("fx_added")
#
#func remove_fx(fx : Dictionary):
	#emit_signal("fx_expired", fx["meta"]["id"])
	#print("fx_remove")

#----------------ACTION & WEAPON
func clear_hold_action():
	hold_action.clear()

#BUILT-IN FUNC
func _ready() -> void:
	setup()

func setup():
	Battle.connect("turn_changed", func(who): can_play = (self == who))

#NOTE UTIL
func take_damage(value):
	hp -= round(value)
	
	if hp <= 0:
		emit_signal("died")
