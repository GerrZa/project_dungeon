@tool
extends RoomNode

@export var battle_scene : String = "uid://dkosn3qlbta03"

@export var lane0 : Array[String] = []
@export var lane1 : Array[String] = []
@export var lane2 : Array[String] = []

@export var combo_list : Array[String] = []

@export var buff_override := {}

@export var random_combo_pick : bool = false

func _ready() -> void:
	super()

func perform_node():
	get_tree().current_scene.get_node("fader/fader_rect/AnimationPlayer").play("black_in")
	
	transfer_battle_data()
	Global.last_room_name = NodePath(String(name))
	
	await get_tree().current_scene.get_node("fader/fader_rect/AnimationPlayer").animation_finished
	
	var battle_tscn = load(battle_scene)
	
	get_tree().change_scene_to_packed(battle_tscn)

func transfer_battle_data():
	Global.battle_data = {
		"lane0" : lane0,
		"lane1" : lane1,
		"lane2" : lane2,
		"combo_list" : combo_list,
		"buff_override" : buff_override,
		"random_combo_pick" : random_combo_pick
	}
