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

func take_damage(dmg, effect_name = "slash"):
	super(dmg)
	
	if hp > 0:
		$spr_pivot/spr/AnimationPlayer.play("hurt")

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(15, char_type)
		curr_scene.camera.shake(0.3, 4)
		
		curr_scene.use_action_point()
		
		return true

func spr_flash(value : bool):
	$spr_pivot/spr.material.set_shader_parameter("flashing_enable", value)
