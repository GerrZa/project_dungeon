#PLAYER
class_name Battler
extends Node2D

var max_hp = 100
var hp = 100
var fx_list = {}

@onready var Battle : BattleScene = get_parent()

var actionset_list = {} #fill with ActionSets, ActionSet fill with Actions

signal died
signal fx_added(effect_id)
signal fx_expired(effect_id)

var hold_action = []

var can_play = false

#SETTER GETTER
#----------------FX
func add_fx(fx : Dictionary):
	emit_signal("fx_added", fx["meta"]["id"])
	fx_list[fx["meta"]["id"]] = fx
	print("fx_added")

func remove_fx(fx : Dictionary):
	emit_signal("fx_expired", fx["meta"]["id"])
	fx_list.erase(fx["meta"]["id"])
	print("fx_remove")

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
