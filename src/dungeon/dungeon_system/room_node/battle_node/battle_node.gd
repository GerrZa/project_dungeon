@tool
extends RoomNode

@export var battle_scene : String = "uid://dkosn3qlbta03"

func _ready() -> void:
	super()

func perform_node():
	get_tree().current_scene.get_node("fader/fader_rect/AnimationPlayer").play("black_in")
	
	await get_tree().current_scene.get_node("fader/fader_rect/AnimationPlayer").animation_finished
	
	var battle_tscn = load(battle_scene)
	
	get_tree().change_scene_to_packed(battle_tscn)
	
