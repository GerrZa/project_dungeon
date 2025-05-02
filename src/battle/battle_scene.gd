extends Node2D

var enemy_lane = []
var player_lane = []

var lane_y_pos = []

@export var lane_count = 3

var hover_player = null
var selecting_player = null

var player_action_point = 3

var turn = "p"

var turn_count = 0

var curr_combo = "null"
var combo_list = ["RoB", "B1", "Rc", "BoG"]
var combo_active = false

func _ready() -> void:
	#set up
	for i in range(lane_count):
		enemy_lane.append([])
	
	for i in range(lane_count):
		player_lane.append(null)
	
	for i in range(lane_count):
		lane_y_pos.append(0.0)
	 
	combo_list.shuffle()

func save_y_pos():
	if player_lane.has(null):
		return
	
	for i in range(lane_count):
		lane_y_pos[i] = player_lane[i].position.y

func rearrange_ene():
	for i in range(enemy_lane.size()):
		for j in range(enemy_lane[i].size()):
			enemy_lane[i][j].to_pos = Vector2(260 + (32 * j), lane_y_pos[i])

func register_player(player : Node2D, lane):
	lane = clamp(lane, 0, 2)
	player_lane[lane] = player

func add_enemy(enemy : Node2D, lane):
	lane = clamp(lane, 0, 2)
	enemy_lane[lane].append(enemy)
	enemy.position = Vector2(430, lane_y_pos[lane])
	enemy.to_pos = Vector2(260 + (32 * (enemy_lane[lane].size() - 1)), lane_y_pos[lane])
	
	enemy.lane = lane
	
	add_child(enemy)

func _process(delta: float) -> void:
	queue_redraw()
	save_y_pos()
	
	#player hover checking
	
	
	for i in player_lane:
		i.modulate.a = 0.3
	
	hover_player = null
	
	for i in player_lane:
		if i.mouse_in:
			hover_player = i
			
			break
	
	if hover_player != null:
		hover_player.modulate.a = 0.7
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			selecting_player = hover_player
	
	if selecting_player != null:
		selecting_player.modulate.a = 1.0
	
	if Input.is_action_just_pressed("ui_accept"):
		if lane_y_pos.has(null) == false:
			randomize()
			var rnd_lane = randi_range(0, 2)
			
			var new_ene = load("res://src/battle/enemy/dummy_battle.tscn")
			var ene_ins = new_ene.instantiate()
			
			add_enemy(ene_ins, rnd_lane)
	
	if Input.is_action_just_pressed("ui_right"):
		randomize()
		var rnd_lane = randi_range(0,2)
		
		enemy_lane[rnd_lane][0].take_damage(10)
	
	curr_combo = combo_list[0]
	combo_active = false
	
	match curr_combo:
		"RoB":
			var half = false
			for i in player_lane:
				if i.char_type == 1:
					half = true
				if half and i.char_type == 0:
					combo_active = true
		"B1":
			if player_lane[2].char_type == 1:
				combo_active = true
		"Rc":
			if player_lane[1].char_type == 0:
				combo_active = true
		"BoG":
			var half = false
			for i in player_lane:
				if i.char_type == 2:
					half = true
				if half and i.char_type == 1:
					combo_active = true

func _draw() -> void:
	if lane_y_pos.size() < lane_count:
		return
	
	for i in range(lane_y_pos.size()):
		draw_line(Vector2(0, lane_y_pos[i]), Vector2(400, lane_y_pos[i]), Color(1,0,0,0.2), 4)


func _on_attack_pressed() -> void:
	if selecting_player == null or enemy_lane[selecting_player.lane].size() <= 0 or player_action_point <= 0 or turn != "p":
		return
	
	if enemy_lane[selecting_player.lane].size() > 0:
		enemy_lane[selecting_player.lane][0].take_damage(15, selecting_player.char_type)
		player_action_point -= 1


func _on_swapup_pressed() -> void:
	if selecting_player.lane >= 2 or player_action_point <= 0 or turn != "p":
		return
	
	var main_lane = selecting_player.lane
	var swap_lane = main_lane+1
	
	var main_pos = selecting_player.to_pos
	var swap_pos = player_lane[swap_lane].to_pos
	
	print("----------")
	print(main_lane)
	print(swap_lane)
	print("----------")
	
	player_lane[main_lane].to_pos = swap_pos
	player_lane[swap_lane].to_pos = main_pos
	
	player_lane[swap_lane].lane = main_lane
	player_lane[main_lane].lane = swap_lane
	
	var main_plr = player_lane[main_lane]
	var swap_plr = player_lane[swap_lane]
	
	player_lane[main_lane] = swap_plr
	player_lane[swap_lane] = main_plr
	
	player_action_point -= 1


func _on_swapdown_pressed() -> void:
	if selecting_player.lane <=0 or player_action_point <= 0 or turn != "p":
		return
	
	var main_lane = selecting_player.lane
	var swap_lane = main_lane-1
	
	var main_pos = selecting_player.to_pos
	var swap_pos = player_lane[swap_lane].to_pos
	
	player_lane[main_lane].to_pos = swap_pos
	player_lane[swap_lane].to_pos = main_pos
	
	player_lane[swap_lane].lane = main_lane
	player_lane[main_lane].lane = swap_lane
	
	var main_plr = player_lane[main_lane]
	var swap_plr = player_lane[swap_lane]
	
	player_lane[main_lane] = swap_plr
	player_lane[swap_lane] = main_plr
	
	player_action_point -= 1


func _on_endturn_pressed() -> void:
	turn = "e"
	
	await get_tree().create_timer(1).timeout
	
	#enemy atk
	for i in enemy_lane:
		if i.size() > 0:
			randomize()
			var rnd = randf()
			
			print(rnd)
			
			if rnd > 0.5 and i[0].hp < 30:
				var rnd_lane = randi_range(0,2)
				
				i[0].lane = rnd_lane
				enemy_lane[rnd_lane].append(i[0])
				i.erase(i[0])
				
				rearrange_ene()
			else:
				var dmg = 15
				
				if combo_active:
					dmg *= 0.5
					dmg = round(dmg)
				
				i[0].attack(dmg)
	
	turn_count += 1
	
	if turn_count % 3 == 0:
		randomize()
		#var rnd_lane = randi_range(0, 2)
		#
		#var new_ene = load("res://src/battle/enemy/dummy_battle.tscn")
		#var ene_ins = new_ene.instantiate()
		#
		#add_enemy(ene_ins, rnd_lane)
		
		combo_list.shuffle()
	
	turn = "p"
	player_action_point = 3
