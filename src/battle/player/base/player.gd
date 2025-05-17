class_name Player
extends MouseDetectArea2D

@export var lane = 0
@export var char_type := Global.TYPE.RED

var max_hp = 100
var hp = 100

var to_pos = Vector2.ZERO
@onready var curr_scene : BattleScene = get_tree().current_scene
@onready var ui = curr_scene.ui

signal action_finish
signal died(lane)

var alive = true

func _ready() -> void:
	super()
	to_pos = position
	max_hp = PlayerData.member_info[char_type]["max_hp"]
	hp = PlayerData.member_info[char_type]["hp"]
	alive = PlayerData.member_info[char_type]["alive"]

func take_damage(dmg):
	if curr_scene.curr_buff == "shield" and curr_scene.combo_active:
		dmg = int(round(dmg * 0.7))
	
	ParticleSpawner.spawn(ParticleSpawner.PARTS.FLOATING_TEXT, curr_scene, [global_position - Vector2(0, 30), var_to_str(dmg), true, Color.RED, 50.0, 0.65, true, 2])
	
	hp -= dmg
	
	if hp <= 0:
		emit_signal("died", lane)
		alive = false

func _physics_process(delta: float) -> void:
	if get_tree().current_scene.player_lane.has(self) == false:
		curr_scene.player_lane[lane] = self
	
	position = lerp(position, to_pos, 0.15)
	
	if alive:
		$spr_pivot/spr/death_icon.visible = false
		if curr_scene.selecting_player == self and curr_scene.turn == "p":
			$spr_pivot/spr.material.set_shader_parameter("active", true)
			$spr_pivot.position.x = lerp($spr_pivot.position.x, 10.0, 0.2)
			$spr_pivot/spr.self_modulate.v = 1
		elif curr_scene.hover_player == self:
			$spr_pivot/spr.self_modulate.v = 1
			$spr_pivot.position.x = lerp($spr_pivot.position.x, 6.0, 0.2)
		else:
			$spr_pivot/spr.self_modulate.v = 0.7
			$spr_pivot/spr.material.set_shader_parameter("active", false)
			$spr_pivot.position.x = lerp($spr_pivot.position.x, 0.0, 0.2)
	else:
		$spr_pivot/spr/death_icon.visible = true
		$spr_pivot/spr.self_modulate.v = 0.5
		$spr_pivot/spr.material.set_shader_parameter("active", false)
		$spr_pivot.position.x = lerp($spr_pivot.position.x, -16.0, 0.2)
		
	
	$spr_pivot/spr.material.set_shader_parameter("alpha", 0.5 + (0.5*abs(cos(PI*Time.get_ticks_msec()/500))))
	
	$mini_hp_bar.modulate.a = 0
	
	if curr_scene.turn == "e":
		$mini_hp_bar.modulate.a = 1
	elif curr_scene.hover_player == self and curr_scene.selecting_player != curr_scene.hover_player:
		$mini_hp_bar.modulate.a = 0.7
	$mini_hp_bar.max_value = max_hp
	$mini_hp_bar.value = hp
	
	$spr_pivot/spr/combo_ring.rotation = -$spr_pivot/spr.rotation
	
	if curr_scene.combo_active:
		$spr_pivot/spr/combo_ring.modulate.a = lerp($spr_pivot/spr/combo_ring.modulate.a, 1.0, 0.1)
	else:
		$spr_pivot/spr/combo_ring.modulate.a = lerp($spr_pivot/spr/combo_ring.modulate.a, 0.0, 0.15)

func save_data():
	PlayerData.member_info[char_type]["hp"] = hp
	PlayerData.member_info[char_type]["max_hp"] = max_hp
	PlayerData.member_info[char_type]["alive"] = alive
