class_name BattleScene
extends Node2D

@export var player_path : NodePath
@export var enemy_path : NodePath

@onready var player = get_node(player_path)
@onready var enemy = get_node(enemy_path)

enum FX{
	FIRE,
	POISON,
	BLEED
}

func _ready() -> void:
	var myfunc = print.bind("HelloWorld")
	
	myfunc.call()

func execute_action(action_seq):
	for i in action_seq:
		i.call()

func damage(caller, victim, damage):
	victim.hp -= damage
	
	return damage

func add_effect(caller, victim, effect):
	victim.get_effect_stack.append(effect)
	
	return effect
