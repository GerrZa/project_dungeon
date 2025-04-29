class_name Effect
extends Node

@export var display : String = "UntitledEffect"
var hold_func = [] #funciton holding to perform in action runthrough
var active = false

var duration = 1

@onready var Battle : BattleScene = get_tree().current_scene

func _ready() -> void:
	await get_tree().current_scene.ready
	
	Battle.connect("turn_changed", func(who): active = true)

#for battlescene to call in effect run through
func perform(caller : Battler, victim : Battler):
	pass
