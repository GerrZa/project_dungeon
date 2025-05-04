class_name BattleScene
extends Node2D

var enemy_lane = []
var player_lane = []

@export var player_action_point = 3
@export var lane_count = 3

@export var enemy_gap = 24
@onready var camera : CameraPlus2D = $CameraPlus2D

#LOW LEVEL
var lane_y_pos = []

var hover_player = null
var selecting_player = null

var turn = "p"
var turn_count = 0

func _ready() -> void:
	#set up
	for i in range(lane_count):
		enemy_lane.append([])
	
	for i in range(lane_count):
		player_lane.append(null)
	
	#for i in range(lane_count):
		#lane_y_pos.append(0.0)

func _process(delta: float) -> void:
	queue_redraw()
	
	if lane_y_pos.size() < 3 and player_lane.has(null) == false:
		for i in player_lane:
			lane_y_pos.append(i.position.y)
	
	#player mouse checking
	hover_player = null
	
	if player_lane.has(null):
		return
	
	for i in player_lane:
		if i != null and i.mouse_in:
			hover_player = i
			
			if Input.is_action_just_pressed("m1"):
				selecting_player = i
				$ui.reload_action_list()
			break
	
	if Input.is_action_just_pressed("ui_accept"):
		add_enemy(1,"res://src/battle/enemy/dummy_battle.tscn")
	if Input.is_action_just_pressed("ui_up"):
		swap_enemy(enemy_lane[0][0], 2, 0)

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

func swap_enemy(who, to_lane, to_index):
	var from_lane = 0
	var from_index = 0
	
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
	
	enemy_lane[from_lane].erase(who)
	enemy_lane[to_lane].insert(clamp(to_index, 0, enemy_lane[to_lane].size()), who)
	
	rearrange_enemy()

func rearrange_enemy():
	for i in range(enemy_lane.size()):
		for j in range(enemy_lane[i].size()):
			
			enemy_lane[i][j].to_pos = Vector2((300) + (j * enemy_gap), lane_y_pos[i])
			enemy_lane[i][j].z_index = enemy_lane[i].size()-j
			

func _draw() -> void:
	#for i in lane_y_pos:
		#draw_line(Vector2(0, i),Vector2(400, i), Color.RED, 2)
	pass
