extends Player

#weapon action list
var sword_action_list = {
	"Slash" : {"call" : attack,
				 "desc" : "Deal [color=red]15 damages[/color] to\nthe front enemy in the line\n\n-Use  15  [color=yellow]Stamina (STA)[/color]",
				 "cond" : func(): 
		if curr_scene.player_resource["STA"][0] < 15:
			return false
		else:
			return true}
}

#weapon library
var weapon_action_list = {
	"regular_sword" : sword_action_list
}

#dont touch
var port = preload("res://asset/battle/char/port/witch_port.png")

#dont touch
var used_res = ["MP", "WP"]

func _ready() -> void:
	super()
	action_list = weapon_action_list[PlayerData.member_info[char_type]["weapon"]]

func _physics_process(delta: float) -> void:
	super(delta)
	$lane_label.text = var_to_str(lane)
	

func take_damage(dmg, effect_name = "slash"):
	super(dmg)
	
	if hp > 0:
		$spr_pivot/spr/AnimationPlayer.stop()
		$spr_pivot/spr/AnimationPlayer.play("hurt")

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(15, char_type)
		curr_scene.camera.shake(0.3, 4)
		
		curr_scene.use_action_point()
		
		await get_tree().create_timer(0.2).timeout
		
		return true

func spr_flash(value : bool):
	$spr_pivot/spr.material.set_shader_parameter("flashing_enable", value)
