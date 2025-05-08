extends Player

var action_list = {
	"Stealll" : {"call" : attack, "desc" : "Test", "cond" : func(): return true},
	"WVINKKK" : {"call" : attack, "desc" : "Test", "cond" : func(): return true}
}

var port = preload("res://asset/battle/char/port/theif_port.png")

var used_res = ["STA", "MP"]

func _physics_process(delta: float) -> void:
	super(delta)
	$lane_label.text = var_to_str(lane)
	
	$mini_hp_bar.modulate.a = 0
	
	if curr_scene.turn == "e":
		$mini_hp_bar.modulate.a = 1
	elif curr_scene.hover_player == self and curr_scene.selecting_player != curr_scene.hover_player:
		$mini_hp_bar.modulate.a = 0.7
	$mini_hp_bar.max_value = max_hp
	$mini_hp_bar.value = hp

func take_damage(dmg, effect_name = "slash"):
	super(dmg)
	
	if hp > 0:
		$spr_pivot/spr/AnimationPlayer.play("hurt")

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(15)
		curr_scene.camera.shake(0.3, 4)
		
		curr_scene.use_action_point()
		
		return true
