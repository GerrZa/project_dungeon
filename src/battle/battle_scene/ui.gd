extends CanvasLayer

@onready var curr_scene : BattleScene = get_tree().current_scene
var act_button = preload("res://src/battle/ui/action_button.tscn")

#func _process(delta: float) -> void:
	#if curr_scene.selecting_player != null:
#		

func reload_action_list():
	if curr_scene.selecting_player != null:
		for i in $action_button.get_children():
			i.queue_free()
		
		for i in curr_scene.selecting_player.action_list.keys():
			var act_ins = act_button.instantiate()
			act_ins.text = i
			
			act_ins.connect("button_pressed", curr_scene.selecting_player.action_list[i])
			
			$action_button.add_child(act_ins)
