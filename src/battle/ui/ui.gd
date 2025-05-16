extends CanvasLayer

@onready var curr_scene : BattleScene = get_tree().current_scene
var act_button = preload("res://src/battle/ui/action_button.tscn")

var can_act = true

signal player_action_finish

var action_condition = {}

var swap_disable_duration = 0.2

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
	
# only called when changing selecting player
func reload_action_list(): #when switching player
	action_condition.clear()
	
	disable_all()
	
	var k = 0
	
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
			
			act_ins.position = Vector2(0,20 * k)
			act_ins.anchor_z_index = 30 - k
			
			#add tool tip
			var tooltip_ins = load("res://src/battle/ui/tooltip.tscn").instantiate()
			
			tooltip_ins.tip_text = "[color=yellow][{0}][/color]\n\n{1}".format([i, curr_scene.selecting_player.action_list[i]["desc"]])
			tooltip_ins.size = act_ins.size
			
			act_ins.add_child(tooltip_ins)
			
			k+=1
		
		#for i in action_condition.keys():
			#print(i)
		
		disable_all()
		enable_all_avai()
		refresh_hp_and_res(true)
		
		$anchor/Port.texture = curr_scene.selecting_player.port

func disable_all():
	$anchor/swap_down.disable = true
	$anchor/swap_up.disable = true
	$anchor/endturn_button.disable = true
	
	for i in $anchor/action_button.get_children():
		if i is ButtonPanel:
			i.disable = true

func enable_all_avai():
	if curr_scene.player_action_point <= 0:
		$anchor/endturn_button.disable = false
	else:
		if curr_scene.selecting_player.lane > 0:
			$anchor/swap_down.disable = false
		if curr_scene.selecting_player.lane < 2:
			$anchor/swap_up.disable = false
		
		for i in $anchor/action_button.get_children():
			if i is ButtonPanel:
				if action_condition[i].call() == true and curr_scene.player_action_point > 0:
					i.disable = false

func refresh_hp_and_res(change_player = false):
	var source = null
	var res_color = {
		"STA" : Color("c5e857"),
		"MP" : Color("6378a6"),
		"WP" : Color("925678")
	}
	
	var res_tooltip = {
		Global.TYPE.RED : ["[color=Gainsboro ][color=Gold][Stamina][/color] will\nbe shared with [color=Yellowgreen] [Theif]",
							"[color=Gainsboro ][color=Orange][WillPower][/color] will\nbe shared with [color=Royalblue] [Witch]"],
		Global.TYPE.BLUE : ["[color=Gainsboro ][color=Royalblue][ManaPoint][/color] will\nbe shared with [color=Yellowgreen] [Theif]",
							"[color=Gainsboro ][color=Gold][WillPower][/color] will\nbe shared with [color=Orangered] [SwordMan]"],
		Global.TYPE.GREEN : ["[color=Gainsboro ][color=Gold][Stamina][/color] will\nbe shared with [color=Orangered] [SwordMan]",
							"[color=Gainsboro ][color=Royalblue][ManaPoint][/color] will\nbe shared with [color=Royalblue] [Witch]"]
	}
	
	var res_texture = {
		Global.TYPE.RED : [load("res://asset/battle/ui/tooltip/share/theif_share.png"),
							load("res://asset/battle/ui/tooltip/share/witch_share.png")],
		Global.TYPE.BLUE : [load("res://asset/battle/ui/tooltip/share/theif_share.png"),
							load("res://asset/battle/ui/tooltip/share/swordman_share.png")],
		Global.TYPE.GREEN : [load("res://asset/battle/ui/tooltip/share/swordman_share.png"),
							load("res://asset/battle/ui/tooltip/share/witch_share.png")]
	}
	
	source = curr_scene.selecting_player
	
	if change_player == false:
		$anchor/hp.value = source.hp
		$anchor/hp.max_value = source.max_hp
		
		$anchor/res1.value = curr_scene.player_resource[source.used_res[0]][0]
		$anchor/res1.max_value = curr_scene.player_resource[source.used_res[0]][1]
		
		$anchor/res2.value = curr_scene.player_resource[source.used_res[1]][0]
		$anchor/res2.max_value = curr_scene.player_resource[source.used_res[1]][1]
		
	else:
		$anchor/hp.reset_value(source.hp, source.max_hp)
		
		$anchor/res1.reset_value(curr_scene.player_resource[source.used_res[0]][0], curr_scene.player_resource[source.used_res[0]][1])
		$anchor/res2.reset_value(curr_scene.player_resource[source.used_res[1]][0], curr_scene.player_resource[source.used_res[1]][1])
	
	
	
	$anchor/res1.modulate = res_color[source.used_res[0]]
	$anchor/res1.value_name = source.used_res[0]
	
	$anchor/res2.modulate = res_color[source.used_res[1]]
	$anchor/res2.value_name = source.used_res[1]
	
	$anchor/share_info1.tip_text = res_tooltip[source.char_type][0]
	$anchor/share_info1.icon_texture = res_texture[source.char_type][0]
	
	$anchor/share_info2.tip_text = res_tooltip[source.char_type][1]
	$anchor/share_info2.icon_texture = res_texture[source.char_type][1]

func reload_combo_ind():
	$upper_anchor/combo_ind.icon_texture = curr_scene.combo_prop[curr_scene.curr_combo]["icon"]
	$upper_anchor/combo_ind.tip_text = "[color=yellow][{0}][/color]\n{1}\n\n[color=dimgray]-------Buff-------[/color]\n{2}\n{3}".format([curr_scene.combo_prop[curr_scene.curr_combo]["display"], curr_scene.combo_prop[curr_scene.curr_combo]["desc"], curr_scene.buff_desc[curr_scene.combo_prop[curr_scene.curr_combo]["buff"]]["display"], curr_scene.buff_desc[curr_scene.combo_prop[curr_scene.curr_combo]["buff"]]["desc"]])

func on_action_pressed(call : Callable): #check for every time action button pressed
	if can_act == false:
		return
	
	disable_all()
	
	$button_click_sfx.play()
	
	can_act = false
	await call.call()
	
	if curr_scene.check_win():
		return
	else:
		can_act = true
		
		enable_all_avai()

func swap_up():
	if can_act == false:
		return
	
	disable_all()
	
	curr_scene.swap_player(curr_scene.selecting_player.lane, curr_scene.selecting_player.lane+1)
	curr_scene.use_action_point()
	
	can_act = false
	
	for j in range(curr_scene.lane_count):
		if curr_scene.player_lane[j].alive == false and curr_scene.enemy_lane[j].size() > 0:
			await curr_scene.immigrate_enemy(j)
	
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
	
	for j in range(curr_scene.lane_count):
		if curr_scene.player_lane[j].alive == false and curr_scene.enemy_lane[j].size() > 0:
			await curr_scene.immigrate_enemy(j)
	
	await get_tree().create_timer(swap_disable_duration).timeout
	
	can_act = true
	enable_all_avai()
