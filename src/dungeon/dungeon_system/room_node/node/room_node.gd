@tool
class_name RoomNode
extends ButtonPanel


@export var icon : Texture2D = preload("uid://4y5ahqph65pu")
@export_multiline var desc = ""
@export_node_path("RoomNode") var connected_node : Array[NodePath]

@onready var curr_scene = get_tree().current_scene

signal room_action_finished

func _ready() -> void:
	super()
	add_to_group("room_node")
	connect("button_pressed", func(): curr_scene.move_to_room(self))

func _process(delta: float) -> void:
	super(delta)
	
	size = icon.get_size()
	$Tooltip.size = icon.get_size()
	
	$Tooltip.position = Vector2.ZERO
	
	$Tooltip.tip_text = desc
	$Tooltip.icon_texture = icon
	
	var h = 300 - global_position.y
	var w = global_position.x
	$Tooltip.get_node("Icon").position.y = 1 + cos((Time.get_ticks_msec()/500.0) + (h/50.0) + (w/50.0)) * 3
	
	if Engine.is_editor_hint() == false:
		if curr_scene.curr_room.check_can_go(self):# or curr_scene.curr_room == self:
			$Tooltip/Icon.modulate.v = 1.0
		else:
			$Tooltip/Icon.modulate.v = 0.5

func check_can_go(node):
	for i in connected_node:
		if get_node(i) == node:
			return true
	
	return false

func perform_node():
	print("entered : " + name)
	emit_signal("room_action_finished")

func set_last_room():
	Global.last_room = name

func get_room_data():
	return {
		"icon" : icon,
		"desc" : desc,
		"connected_node" : connected_node
		}

func load_data(dat):
	icon = dat["icon"]
	desc = dat["desc"]
	connected_node = dat["connected_node"]
