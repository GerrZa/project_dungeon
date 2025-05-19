extends Player

#weapon action list
var sword_action_list = {
	"Slash" : {"call" : func():
						attack(15)
						use_sta(5)
						use_act_point(),
				 "desc" : "Deal [color=red]15 damages[/color] to\nthe front enemy in the line\n\n-Use  5  [color=yellow]Stamina (STA)[/color]",
				 "cond" : func(): 
		if curr_scene.player_resource["STA"][0] >= 5 and curr_scene.enemy_lane[lane].size() > 0:
			return true
		else:
			return false},
	"Block" : {"call" : func():
						add_shield(20)
						use_sta(10)
						use_act_point(),
				 "desc" : "Create [color=#56b2b4]20 shield units[/color]\nSubtract incoming damage\n\n-Use  10  [color=yellow]Stamina (STA)[/color]",
				 "cond" : func(): 
		if curr_scene.player_resource["STA"][0] >= 10:
			return true
		else:
			return false},
}

var battle_axe_action_list = {
	"Big Slash" : {"call" : func():
						attack(45)
						use_sta(20)
						use_act_point(),
				 "desc" : "Deal [color=red]45 damages[/color] to\nthe front enemy in the line\n\n-Use  20  [color=yellow]Stamina (STA)[/color]",
				 "cond" : func(): 
		if curr_scene.player_resource["STA"][0] >= 20 and curr_scene.enemy_lane[lane].size() > 0:
			return true
		else:
			return false},
}

var addition_stat = {
	"shield" : 0
}

#weapon library
var weapon_action_list = {
	"regular_sword" : sword_action_list
}

var port = preload("res://asset/battle/char/port/sword_man_port.png")

var used_res = ["STA", "WP"]

func _ready() -> void:
	super()
	action_list = weapon_action_list[PlayerData.member_info[char_type]["weapon"]]
	print(weapon_action_list[PlayerData.member_info[char_type]["weapon"]])

func _physics_process(delta: float) -> void:
	super(delta)
	$lane_label.text = var_to_str(lane)

func take_damage(dmg, effect_name = "slash"):
	super(dmg)
	
	if hp > 0:
		$spr_pivot/spr/AnimationPlayer.stop()
		$spr_pivot/spr/AnimationPlayer.play("hurt")

func attack(dmg):
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(dmg, char_type)
		curr_scene.camera.shake(0.2, 2)
		
		curr_scene.ui.refresh_hp_and_res()
		
		$spr_pivot/spr/AnimationPlayer.stop()
		$spr_pivot/spr/AnimationPlayer.play("attack")
		
		await $spr_pivot/spr/AnimationPlayer.animation_finished
		
		return true

#region Shield
func set_shield(amt):
	addition_stat["shield"] = amt

func add_shield(amt):
	addition_stat["shield"] += amt

func subtract_shield(amt):
	addition_stat["shield"] -= amt
#endregion

func use_sta(amt):
	curr_scene.player_resource["STA"][0] -= amt
	curr_scene.ui.refresh_hp_and_res()

func use_act_point():
	curr_scene.use_action_point()

func spr_flash(value : bool):
	$spr_pivot/spr.material.set_shader_parameter("flashing_enable", value)
