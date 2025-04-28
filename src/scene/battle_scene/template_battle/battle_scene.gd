class_name BattleScene
extends Node2D

#NOTE NODE ORGANIZATION
@export var player_path : NodePath
@export var enemy_path : NodePath

@onready var player : Battler = get_node(player_path)
@onready var enemy : Battler = get_node(enemy_path)

var turn = null
func set_turn(value):
	if turn != value:
		turn = value
		emit_signal("turn_changed", value)
signal turn_changed(who)
func switch_turn():
	if turn == player:
		set_turn(enemy)
	else:
		set_turn(player)

#SETUP
@export var player_max_tu := 3
@export var enemy_max_tu := 3

@export var enemy_max_hp : int = 100

#NOTE EFFECT LIBRARY
enum FX{
	FIRE,
	POISON,
	BLEED
}

var FX_FUNC = {
	FX.FIRE : fx_fire,
	FX.POISON : fx_poison
}

var FX_META = { #meta date for each fx
	FX.FIRE : {
		"display" : "Fire",
		"id" : "fire",
		
		"last_damage" : 10
		},
	FX.POISON : {
		"display" : "Poison",
		"id" : "poison",
		
		"last_damage" : -1
		}
}

#NOTE EFFECT FUNC
func fx_fire(caller : Battler, victim : Battler, fx_dict):
	print("FIRE!!!")
	var damage = 10
	victim.take_damage(damage)

func fx_poison(caller, victim, fx_dict):
	var damage = 0
	if fx_dict["meta"]["last_damage"] < 0:
		damage = victim.get_mx_hp() * 0.05
	else:
		damage = fx_dict["meta"]["last_damage"] * 0.75
	
	fx_dict["meta"]["last_damage"] = damage
	
	victim.take_damage(damage)

#NOTE EFFECT
func create_fx(type : FX, duration := 1): #create fx dictionary to use in applyfx()
	var new_fx = {
		"func": FX_FUNC[type],
		"duration" : duration,
		"meta" : FX_META[type]
	}
	
	return new_fx

func apply_fx(caller : Battler, victim : Battler, effect : Dictionary): #apply fx to battler
	effect["func"] = effect["func"].bindv([caller, victim, effect])
	victim.add_fx(effect)
	
	return effect

func create_and_apply_fx(caller : Battler, victim : Battler, type : FX, duration : int,):
	var new_fx = create_fx(type, duration)
	apply_fx(caller, victim, new_fx)

func execute_fx(fx_owner : Battler, fx : Dictionary):
	fx["func"].call()
	fx["duration"] = fx["duration"] - 1
	
	if fx["duration"] == 0:
		fx_owner.remove_fx(fx)

func turn_execute(caller : Battler):
	for a in caller.get_hold_action():
		execute_action(caller, get_opposite_battler(caller), a)
		
		await get_tree().create_timer(1).timeout
	caller.clear_hold_action()
	
	for i in caller.get_fx_list().keys():
		execute_fx(caller, caller.get_fx_list()[i])
	
	switch_turn()

func execute_action(caller : Battler, victim : Battler, action):
	action["func"].callv([caller, victim])

#NOTE UTILITIES
func get_opposite_battler(caller : Battler):
	if caller == player:
		return enemy
	else:
		return player

func damage(caller : Battler, victim : Battler, damage):
	victim.take_damage(damage)
	
	return damage
