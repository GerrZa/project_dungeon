extends Node2D

var enemy_lane = []
var player_lane = []

var lane_y_pos = []

@export var lane_count = 3

var hover_player = null
var selecting_player = null

var player_action_point = 3

func _ready() -> void:
	#set up
	for i in range(lane_count):
		enemy_lane.append([])
	
	for i in range(lane_count):
		player_lane.append(null)
	
	for i in range(lane_count):
		lane_y_pos.append(0.0)

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

func _draw() -> void:
	if lane_y_pos.size() < lane_count:
		return
	
	for i in range(lane_y_pos.size()):
		draw_line(Vector2(0, lane_y_pos[i]), Vector2(400, lane_y_pos[i]), Color(1,0,0,0.2), 4)
