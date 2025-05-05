class_name Player
extends MouseDetectArea2D

@export var lane = 0
@export var char_type : Global.TYPE = Global.TYPE.RED

var max_hp = 100
var hp = 100

var to_pos = Vector2.ZERO
@onready var curr_scene : BattleScene = get_tree().current_scene
@onready var ui = curr_scene.ui

signal action_finish

func _ready() -> void:
	super()
	to_pos = position
	hp = max_hp

func take_damage(dmg):
	hp -= dmg

func _physics_process(delta: float) -> void:
	if get_tree().current_scene.player_lane.has(self) == false:
		curr_scene.player_lane[lane] = self
	
	position = lerp(position, to_pos, 0.15)
	
	if curr_scene.selecting_player == self:
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
	
	$spr_pivot/spr.material.set_shader_parameter("alpha", 0.75 + (0.25*abs(cos(PI*Time.get_ticks_msec()/1000))))
