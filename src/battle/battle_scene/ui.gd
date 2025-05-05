extends CanvasLayer

@onready var curr_scene : BattleScene = get_tree().current_scene
var act_button = preload("res://src/battle/ui/action_button.tscn")

var can_act = true

signal player_action_finish

var action_condition = {}

var swap_disable_duration = 0.4

func _ready() -> void:
	
	for i in $anchor/action_button.get_children():
		i.free()
	
	$anchor/endturn_button.connect("button_pressed", func():
		curr_scene.on_endturn_button_pressed()
		$anchor/endturn_button.disable = true
		)
	
	$anchor/swap_down.connect("button_pressed", swap_down)
	$anchor/swap_up.connect("button_pressed", swap_up)

#func _process(delta: float) -> void:
	#print(action_condition)
	

func reload_action_list(): #when switching player
	action_condition.clear()
	
	disable_all()
	
	if curr_scene.selecting_player != null:
		for i in $anchor/action_button.get_children():
			i.free()
		
		for i in curr_scene.selecting_player.action_list.keys():
			var act_ins = act_button.instantiate()
			act_ins.text = i
			
			if curr_scene.player_action_point > 0 and can_act:
				act_ins.disable = false
			
			act_ins.connect("button_pressed", func() : on_action_pressed(curr_scene.selecting_player.action_list[i]["call"]))
			act_ins.oneshot = false
			
			action_condition[act_ins] = curr_scene.selecting_player.action_list[i]["cond"]
			
			$anchor/action_button.add_child(act_ins)
		
		print("----------")
		
		for i in action_condition.keys():
			print(i)
		
		disable_all()
		enable_all_avai()

func disable_all():
	$anchor/swap_down.disable = true
	$anchor/swap_up.disable = true
	$anchor/inventory.disable = true
	$anchor/endturn_button.disable = true
	
	for i in $anchor/action_button.get_children():
		i.disable = true

func enable_all_avai():
	if curr_scene.player_action_point <= 0:
		$anchor/endturn_button.disable = false
	else:
		if curr_scene.selecting_player.lane > 0:
			$anchor/swap_down.disable = false
		if curr_scene.selecting_player.lane < 2:
			$anchor/swap_up.disable = false
		
		$anchor/inventory.disable = false
		
		for i in $anchor/action_button.get_children():
			if action_condition[i].call() == true and curr_scene.player_action_point > 0:
				i.disable = false

func on_action_pressed(call : Callable): #check for every time action button pressed
	if can_act == false:
		return
	
	disable_all()
	
	can_act = false
	await call.call()
	curr_scene.check_win()
	can_act = true
	
	enable_all_avai()

func swap_up():
	if can_act == false:
		return
	
	disable_all()
	
	curr_scene.swap_player(curr_scene.selecting_player.lane, curr_scene.selecting_player.lane+1)
	curr_scene.use_action_point()
	
	can_act = false
	
	await get_tree().create_timer(swap_disable_duration).timeout
	
	can_act = true
	enable_all_avai()

func swap_down():
	if can_act == false:
		return
	
	disable_all()
	
	curr_scene.swap_player(curr_scene.selecting_player.lane, curr_scene.selecting_player.lane-1)
	curr_scene.use_action_point()
	
	can_act = false
	
	await get_tree().create_timer(swap_disable_duration).timeout
	
	can_act = true
	enable_all_avai()
