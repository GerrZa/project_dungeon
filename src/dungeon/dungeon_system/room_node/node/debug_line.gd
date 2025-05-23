@tool
extends Node2D

var to_col = Color.DIM_GRAY
var col = to_col

func _physics_process(delta: float) -> void:
	col = lerp(col, to_col, 0.1)

func _process(delta: float) -> void:
	queue_redraw()
	
	position = get_parent().icon.get_size()/2

func _draw() -> void:
	#if Engine.is_editor_hint() == false:
		#return
	
	for i in get_parent().connected_node:
		if i is NodePath and i != NodePath(""):
			
			to_col = Color.DIM_GRAY
			
			if Engine.is_editor_hint() or get_parent().curr_scene.curr_room == get_parent():
				to_col = Color.WHITE
			
			if Engine.is_editor_hint() == false and get_parent().curr_scene.can_move == false:
				to_col = Color.DIM_GRAY
			
			draw_line(get_node("../Tooltip/Icon").position, to_local(get_parent().get_node(i).get_node("Tooltip/Icon").global_position + (get_parent().icon.get_size() / 2)), col, 2, false)
			
	
	for i in get_parent().connected_node:
		if i is NodePath and i != NodePath(""):
			if Engine.is_editor_hint():
				draw_circle(get_node("../Tooltip/Icon").position + (to_global(get_node("../Tooltip/Icon").position).direction_to(get_parent().get_node(i).global_position + (get_parent().get_node(i).icon.get_size() / 2)) * 16), 4, Color.RED, true)
			
