#PLAYER
extends Node2D

#ESSENTIAL
var hp = 100.0
var effect_list



@onready var Battle : BattleScene = get_parent()

signal died

#SETTER GETTER
#----------------HP
func get_hp():
	return hp

func set_hp(value):
	hp = value
	
	if hp <= 0:
		emit_signal("died")

func damage(value):
	hp -= value
	
	if hp <= 0:
		emit_signal("died")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
