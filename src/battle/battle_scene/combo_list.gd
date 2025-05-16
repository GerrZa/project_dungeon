extends Node

@export var combo_list : PackedStringArray = ["BoG"]

@export var buff_override : Dictionary = {"BoG" : "shield"}

func _ready() -> void:
	for i in buff_override.keys():
		if get_tree().current_scene.combo_prop.has(i):
			get_tree().current_scene.combo_prop[i]["buff"] = buff_override[i]
			print(i)
			print(get_tree().current_scene.combo_prop[i]["buff"])
