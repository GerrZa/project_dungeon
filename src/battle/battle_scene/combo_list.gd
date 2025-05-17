extends Node

@export var combo_list : PackedStringArray = ["BoG"]

@export var buff_override : Dictionary = {"BoG" : "shield"}

func _init() -> void:
	if Global.battle_data != null:
		combo_list = Global.battle_data["combo_list"]
		buff_override = Global.battle_data["buff_override"]

func _ready() -> void:
	for i in buff_override.keys():
		if get_tree().current_scene.combo_prop.has(i):
			get_tree().current_scene.combo_prop[i]["buff"] = buff_override[i]
			print(i)
			print(get_tree().current_scene.combo_prop[i]["buff"])
