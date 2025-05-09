class_name Enemy
extends MouseDetectArea2D

@export var max_hp = 100
var hp = 100

var to_pos = Vector2.ZERO
@export var lane = 0
var follow_to_pos = true

@onready var curr_scene : BattleScene = get_tree().current_scene

signal dead
signal action_finish

@export var weak : Global.TYPE = Global.TYPE.NONE
@export var weak_amp := 1.5
@export var randomize_weak := true

func _ready() -> void:
	super()
	hp = max_hp
	if randomize_weak:
		randomize()
		weak = randi_range(0,2)

func _physics_process(delta: float) -> void:
	if follow_to_pos:
		position = lerp(position, to_pos, 0.2)
	
	modulate.v = 0.6
	
	if curr_scene.selecting_player != null and curr_scene.selecting_player.lane == lane:
		modulate.v = 1

func take_damage(dmg, from_type):
	if from_type == weak:
		dmg = int(round(dmg * weak_amp))
		
	hp -= dmg
	
	if hp <= 0:
		emit_signal("dead")

func remove_self():
	curr_scene.enemy_lane[lane].erase(self)
	curr_scene.rearrange_enemy()

func perform_action():
	
	#custom code
	
	emit_signal("action_finish")
