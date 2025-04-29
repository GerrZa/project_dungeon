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


#NOTE UTILITIES
func get_opposite_battler(caller : Battler):
	if caller == player:
		return enemy
	else:
		return player

func damage(caller : Battler, victim : Battler, damage):
	victim.take_damage(damage)
	
	return damage
