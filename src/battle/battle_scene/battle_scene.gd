class_name BattleScene
extends Node2D

var enemy_lane = []
var player_lane = []

@export var player_action_point = 3
@export var max_player_action_point = 3
@export var init_player = 1
@export var lane_count = 3

@onready var combo_use_list : PackedStringArray = []
@export var random_combo_pick := false
@export var combo_cycle_turn := 3

@export var enemy_base_x_pos = 270
@export var enemy_gap = 32
@onready var camera : CameraPlus2D = $CameraPlus2D
@onready var ui = $ui

@export_category("Init enemy")
@onready var enemy_initiator = $init_enemy

var action_point_ind = preload("uid://dm6onahdm6ldu")

# Combo naming system
# XoY -> X over Y
# XYZ -> X Y Z in order count from top to bottom 

var combo_prop = {
	"BoG" : {"display" : "Witch over Theif",
	"desc" : "[color=royalblue]Witch[/color]'s position\nhigher than [color=YelloGreen]Theif[/color]",
	"icon" : load("uid://bifoui4cjq6a3"),
	"check" : func() : if get_player_curr_lane()["blue"] > get_player_curr_lane()["green"]: return true else: return false,
	"buff" : "shield"},
	
	"GoB" : {"display" : "Theif over Witch",
	"desc" : "[color=YellowGreen]Theif[/color]'s position\nhigher than [color=royalblue]Witch[/color]",
	"icon" : load("uid://das2s8mpwo55t"),
	"check" : func() : if get_player_curr_lane()["green"] > get_player_curr_lane()["blue"]: return true else: return false,
	"buff" : "shield"},
	
	"RoG" : {"display" : "SwordMan over Theif",
	"desc" : "[color=OrangeRed]SwordMan[/color]'s position\nhigher than [color=YellowGreen]Theif[/color]",
	"icon" : load("uid://bdm0xfbhn2owb"),
	"check" : func() : if get_player_curr_lane()["red"] > get_player_curr_lane()["green"]: return true else: return false,
	"buff" : "shield"},
	
	"GoR" : {"display" : "Theif over SwordMan",
	"desc" : "[color=YellowGreen]Theif[/color]'s position\nhigher than [color=OrangeRed]SwordMan[/color]",
	"icon" : load("uid://b3s40ivpx1sh4"),
	"check" : func() : if get_player_curr_lane()["green"] > get_player_curr_lane()["red"]: return true else: return false,
	"buff" : "shield"},
	
	"BoR" : {"display" : "Witch over SwordMan",
	"desc" : "[color=RoaylBlue]Witch[/color]'s position\nhigher than [color=OrangeRed]SwordMan[/color]",
	"icon" : load("uid://j4xpssly46a3"),
	"check" : func() : if get_player_curr_lane()["blue"] > get_player_curr_lane()["red"]: return true else: return false,
	"buff" : "shield"},
	
	"RoB" : {"display" : "SwordMan over Witch",
	"desc" : "[color=OrangeRed]SwordMan[/color]'s position\nhigher than [color=royalblue]Witch[/color]",
	"icon" : load("uid://bhpbgqrf3bkye"),
	"check" : func() : if get_player_curr_lane()["red"] > get_player_curr_lane()["blue"]: return true else: return false,
	"buff" : "shield"},
	
	
	
	"R0" : {"display" : "SwordMan Top",
	"desc" : "[color=OrangeRed]SwordMan[/color]'s position is at the top",
	"icon" : load("uid://cpp8xd8wi4ijd"),
	"check" : func() : if get_player_curr_lane()["red"] == 2: return true else: return false,
	"buff" : "shield"},
	
	"R1" : {"display" : "SwordMan Center",
	"desc" : "[color=OrangeRed]SwordMan[/color]'s position is at the center",
	"icon" : load("uid://luaanmv7muib"),
	"check" : func() : if get_player_curr_lane()["red"] == 1: return true else: return false,
	"buff" : "shield"},
	
	"R2" : {"display" : "SwordMan Bottom",
	"desc" : "[color=OrangeRed]SwordMan[/color]'s position is at the bottom",
	"icon" : load("uid://cigeyrbmru8ig"),
	"check" : func() : if get_player_curr_lane()["red"] == 0: return true else: return false,
	"buff" : "shield"},
	
	"G0" : {"display" : "Theif Top",
	"desc" : "[color=YellowGreen]Theif[/color]'s position is at the top",
	"icon" : load("uid://dy8o8h5h4g817"),
	"check" : func() : if get_player_curr_lane()["green"] == 2: return true else: return false,
	"buff" : "shield"},
	
	"G1" : {"display" : "Theif Center",
	"desc" : "[color=YellowGreen]Theif[/color]'s position is at the center",
	"icon" : load("uid://7ckij20fra7u"),
	"check" : func() : if get_player_curr_lane()["green"] == 1: return true else: return false,
	"buff" : "shield"},
	
	"G2" : {"display" : "Theif Bottom",
	"desc" : "[color=OrangeRed]SwordMan[/color]'s position is in the bottom",
	"icon" : load("uid://cbrfntvbytkt2"),
	"check" : func() : if get_player_curr_lane()["green"] == 0: return true else: return false,
	"buff" : "shield"},
	
	"B0" : {"display" : "Witch Top",
	"desc" : "[color=RoyalBlue]Witch[/color]'s position is at the top",
	"icon" : load("uid://cv0bha1wpf0a2"),
	"check" : func() : if get_player_curr_lane()["blue"] == 2: return true else: return false,
	"buff" : "shield"},
	
	"B1" : {"display" : "Witch Center",
	"desc" : "[color=RoyalBlue]Witch[/color]'s position is at the center",
	"icon" : load("uid://by3f4hislb4xg"),
	"check" : func() : if get_player_curr_lane()["blue"] == 1: return true else: return false,
	"buff" : "shield"},
	
	"B2" : {"display" : "Witch Bottom",
	"desc" : "[color=RoyalBlue]Witch[/color]'s position is in the bottom",
	"icon" : load("uid://b2m5dchve84h8"),
	"check" : func() : if get_player_curr_lane()["blue"] == 0: return true else: return false,
	"buff" : "shield"},
}

var buff_desc = {
	"shield" : {"display" : "[color=Cyan]Holy Shield[/color]", "desc" : "Take less damage from enemy."},
	"test" : {"display" : "[color=Fuchsia]TEST[/color]", "desc" : "Just for testing shit-ish"},
}

var curr_combo = ""
var curr_buff = ""

var combo_active = false

var player_resource = {
	"STA" : [100.0,100.0],
	"MP" : [100.0,100.0],
	"WP" : [100.0,100.0]
}

#LOW LEVEL
var lane_y_pos = []

var hover_player = null
var selecting_player = null

var last_selected_player = null

var turn = "setup"
var turn_count = -1

var hover_enemy = null

var to_action_enemy_list = []

signal enemy_turn_finished

signal enter_player_turn
signal enter_enemy_turn

func _init() -> void:
	random_combo_pick = Global.battle_data["random_combo_pick"]

func _ready() -> void:
	player_action_point = max_player_action_point
	combo_use_list = $combo_list.combo_list
	
	for i in range(max_player_action_point):
		var ap_ins = action_point_ind.instantiate()
		
		ui.get_node("upper_anchor/action_point_sorter").add_child(ap_ins)
	ui.get_node("upper_anchor/action_point_sorter").sort()
	
	#set up
	for i in range(lane_count):
		enemy_lane.append([])
	
	for i in range(lane_count):
		player_lane.append(null)
	

func _process(delta: float) -> void:
	queue_redraw()
	
	#multi turn function
	if turn == "e" or turn == "p":
		hover_enemy = null
		
		for i in enemy_lane:
			for j in i:
				if j.mouse_in:
					hover_enemy = j
					break
	
	match turn:
		"setup":
			#set up
			if lane_y_pos.size() < 3 and player_lane.has(null) == false:
				
				var ii = 1
				for i in player_lane:
					lane_y_pos.append(i.position.y)
					i.to_pos = i.position
					i.position.x -= 200 + (100*ii)
					ii+=1
				
				#init enemy
				for i in enemy_initiator.lane0:
					add_enemy(0, "res://src/battle/enemy/" +i+ "/" +i+ "_battle.tscn")
				if lane_count > 1:
					for i in enemy_initiator.lane1:
						add_enemy(1, "res://src/battle/enemy/" +i+ "/" +i+ "_battle.tscn")
				if lane_count > 2:
					for i in enemy_initiator.lane2:
						add_enemy(2, "res://src/battle/enemy/" +i+ "/" +i+ "_battle.tscn")
				
				for j in range(lane_count):
					if player_lane[j].alive == false and enemy_lane[j].size() > 0:
						await immigrate_enemy(j)
				
				selecting_player = player_lane[clamp(init_player, 0, lane_count)]
				$ui/fader_layer/fader/AnimationPlayer.play("black_out")
				
				await get_tree().create_timer(0.3 * lane_count).timeout
				
				
				#print(selecting_player)
				switch_turn("p")
		"p":
			
			#player mouse checking
			hover_player = null
			
			#print(combo_use_list, combo_active, curr_combo)
			
			for i in player_lane:
				if i != null and i.alive and i.mouse_in:
					hover_player = i
					
					if Input.is_action_just_pressed("m1"):
						if hover_player != selecting_player:
							selecting_player = i
							$ui.reload_action_list()
					break
			
			#debug shit
			#if Input.is_action_just_pressed("ui_accept"):
				#randomize()
				#
				#var rng = randi_range(0,2)
				#
				#add_enemy(rng,"res://src/battle/enemy/dummy/dummy_battle.tscn")
			#if Input.is_action_just_pressed("ui_up"):
				#swap_player(0,2)
		"e":
			hover_player = null
		"win":
			$win.visible = true
			hover_player = null
			selecting_player = null
		"lose":
			$win.text = "LOSE"
			$win.visible = true
			hover_player = null
			selecting_player = null

#Game stuff
func use_action_point(amt = 1):
	ui.get_node("upper_anchor/action_point_sorter").get_child(player_action_point - 1).disable()
	player_action_point -= amt

func reset_action_point():
	player_action_point = max_player_action_point

func add_action_point(amt = 1):
	player_action_point += amt

func switch_turn(to_who):
	turn = to_who
	match to_who:
		"p":
			emit_signal("enter_player_turn")
			turn_count += 1
			if turn_count > 0 and turn_count % 3 == 0:
				if random_combo_pick == false:
					#cycle the combo list, current combo based on the first element of "combo_use_list" array
					var pop_comb = combo_use_list[0]
					combo_use_list.remove_at(0)
					combo_use_list.append(pop_comb)
				else:
					randomize()
					
					var rnd_i = randi_range(min(combo_use_list.size()-1,1), combo_use_list.size()-1)
					var pop_comb = combo_use_list[rnd_i]
					combo_use_list.remove_at(rnd_i)
					combo_use_list.insert(0, pop_comb)
			
			curr_combo = combo_use_list[0]
			curr_buff = combo_prop[curr_combo]["buff"]
			
			ui.reload_combo_ind()
			check_combo()
			
			for i in ui.get_node("upper_anchor/action_point_sorter").get_children():
				i.reset()
			
			$ui/anchor/AnimationPlayer.play("slide_in")
			$ui.reload_action_list()
			
			await $ui/anchor/AnimationPlayer.animation_finished
			
			reset_action_point()
			#$ui.reload_action_list()
			$ui.disable_all()
			$ui.enable_all_avai()
			
		"e":
			get_to_action_enemy_list()
			emit_signal("enter_enemy_turn")
			$ui/anchor/AnimationPlayer.play("slide_out")
			
			await $ui/anchor/AnimationPlayer.animation_finished
			
			call_enemy_action()
			$ui.disable_all()
			
			emit_signal("enemy_turn_finished")
		"win":
			
			$ui.disable_all()
			
			change_scene_back_to_dungeon()
			for i in player_lane:
				i.save_data()

func change_scene_back_to_dungeon():
			await get_tree().create_timer(1).timeout
			$ui/fader_layer/fader/AnimationPlayer.play("black_in")
			
			await $ui/fader_layer/fader/AnimationPlayer.animation_finished
			
			Global.get_tree().change_scene_to_file(Global.last_level_uid)

func check_win():
	var sum_ene = 0
	
	for i in enemy_lane:
		sum_ene += i.size()
	
	
	if sum_ene <= 0:
		if turn == "p":
			$ui/anchor/AnimationPlayer.play("slide_out")
		
		switch_turn("win")
		return true
	
	return false

func check_lose():
	for i in player_lane:
		if i.alive:
			return false
	
	switch_turn("lose")
	return true

#Player stuff
func swap_player(from_lane, to_lane):
	var from_pos = player_lane[from_lane].to_pos
	var to_pos = player_lane[to_lane].to_pos
	
	var from_player = player_lane[from_lane]
	var to_player = player_lane[to_lane]
	
	from_player.to_pos = to_pos
	to_player.to_pos = from_pos
	
	from_player.lane = to_lane
	to_player.lane = from_lane
	
	player_lane[from_lane] = to_player
	player_lane[to_lane] = from_player
	
	check_combo()

func check_combo():
	if combo_prop[curr_combo]["check"].call():
		combo_active = true
		return true
	else:
		combo_active = false
		return false	

func get_player_curr_lane():
	return {"red" : $RedPlayer.lane, "blue" : $BluePlayer.lane, "green" : $GreenPlayer.lane}

#Enemy stuff
func add_enemy(lane, enemy_file, index = -1):
	var ene = load(enemy_file)
	var ene_ins = ene.instantiate()
	
	ene_ins.lane = lane
	ene_ins.position = Vector2(430, lane_y_pos[lane])
	
	if index > 0:
		enemy_lane[lane].insert(clamp(index, 0, enemy_lane[lane].size()), ene_ins)
	else:
		enemy_lane[lane].append(ene_ins)
	
	add_child(ene_ins)
	
	rearrange_enemy()
	pass

func swap_enemy(who, to_lane, to_index): #who : Node2D
	var from_lane = 0
	var from_index = 0
	
	#finiding "who"
	for i in range(enemy_lane.size()):
		for j in range(enemy_lane[i].size()):
			
			if enemy_lane[i][j] == who:
				from_lane = i
				from_index = j
				break
			
			#not found
			if i == enemy_lane.size() and j == enemy_lane[i].size():
				return
			pass
	
	who.lane = to_lane
	
	enemy_lane[from_lane].erase(who)
	enemy_lane[to_lane].insert(clamp(to_index, 0, enemy_lane[to_lane].size()), who)
	
	rearrange_enemy()

func rearrange_enemy():
	for i in range(enemy_lane.size()):
		for j in range(enemy_lane[i].size()):
			
			enemy_lane[i][j].to_pos = Vector2((enemy_base_x_pos) + (j * enemy_gap), lane_y_pos[i])
			enemy_lane[i][j].z_index = enemy_lane[i].size()-j + ((enemy_lane.size() - i)*10)
			

func get_to_action_enemy_list():
	to_action_enemy_list = []
	
	for i in range(enemy_lane.size()):
		var ii = enemy_lane.size() - i - 1
		
		for j in enemy_lane[ii]:
			if j.will_attack:
				to_action_enemy_list.append(j)

func call_enemy_action():
	get_to_action_enemy_list()
	
	for i in to_action_enemy_list:
		if turn != "e":
			break
		
		i.perform_action()
		
		ui.refresh_hp_and_res()
		
		await i.action_finish
		
		for j in range(lane_count):
			if player_lane[j].alive == false and enemy_lane[j].size() > 0:
				await immigrate_enemy(j)
	
	for i in enemy_lane:
		for j in i:
			j.add_turn_count()
	
	if check_win():
		return
	
	if check_lose():
		return
	
	emit_signal("enemy_turn_finished")
	switch_turn("p")
	pass

func immigrate_enemy(lane):
	var immigrate_lane
	
	if check_lose():
		return false
	
	if lane_count == 3 and lane == 1:
		var pool = []
		
		for i in player_lane:
			if i.alive:
				pool.append(i.lane)
		randomize()
		
		immigrate_lane = pool.pick_random()
		
	else:
		if lane == 0:
			if player_lane[lane+1].alive:
				immigrate_lane = lane+1
			else:
				immigrate_lane = lane+2
		elif lane == lane_count - 1:
			if player_lane[lane-1].alive:
				immigrate_lane = lane-1
			else:
				immigrate_lane = lane-2
	
	var enemy_inlane = []
	
	for i in enemy_lane[lane]:
		enemy_inlane.append(i)
	
	for i in enemy_inlane:
		print(enemy_inlane)
		swap_enemy(i, immigrate_lane, 99)
		
		await get_tree().create_timer(0.1).timeout
	
	return true

func _draw() -> void:
	#for i in lane_y_pos:
		#draw_line(Vector2(0, i),Vector2(400, i), Color.RED, 2)
	pass

#UI stuff
func on_endturn_button_pressed():
	check_win()
	switch_turn("e")
