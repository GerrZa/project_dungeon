extends Node

@export var lane0 : PackedStringArray = []
@export var lane1 : PackedStringArray = []
@export var lane2 : PackedStringArray = []

func _init() -> void:
	if Global.battle_data != null:
		lane0 = Global.battle_data["lane0"]
		lane1 = Global.battle_data["lane1"]
		lane2 = Global.battle_data["lane2"]
