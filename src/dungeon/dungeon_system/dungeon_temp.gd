class_name Dungeon
extends Node2D

@export_node_path("RoomNode") var init_room : NodePath
var curr_room = null

var can_move = false

func _ready() -> void:
	if curr_room == null:
		curr_room = get_node(init_room)
	
	if Global.last_room_name != null:
		curr_room = get_node(Global.last_room_name)
		load_room_data()
	
	$party_icon.global_position = curr_room.get_node("Tooltip/Icon").global_position + (curr_room.icon.get_size()/2)
	
	$camera_anchor.global_position.y = $party_icon.global_position.y
	
	$fader/fader_rect/AnimationPlayer.play("black_out")
	
	await $fader/fader_rect/AnimationPlayer.animation_finished
	
	can_move = true
	
	Global.last_level_uid = scene_file_path


func _physics_process(delta: float) -> void:
	$party_icon.global_position = lerp($party_icon.global_position, curr_room.global_position + (curr_room.icon.get_size()/2), 0.1)
	$party_icon.offset.y = -5 + curr_room.get_node("Tooltip/Icon").position.y

func move_to_room(node):
	if curr_room.check_can_go(node) == false or can_move == false:
		return false
	
	curr_room = node
	
	can_move = false
	await get_tree().create_timer(0.5).timeout #wait for party step on room
	
	curr_room.connect("room_action_finished", func(): can_move = true)
	
	curr_room.perform_node()

func load_room_data():
	for i in get_tree().get_nodes_in_group("room_node"):
		if Global.room_data is Dictionary and Global.room_data.has(i.name):
			i.load_data(Global.room_data[i.name])
	
	Global.room_data = null
