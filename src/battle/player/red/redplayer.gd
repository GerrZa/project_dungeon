extends Player

var action_list = {
	"Slash" : {"call" : attack, "cond" : func(): return true}
}

var port = preload("res://asset/battle/char/port/sword_man_port.png")

func _physics_process(delta: float) -> void:
	super(delta)
	$lane_label.text = var_to_str(lane)

func take_damage(dmg, effect_name = "slash"):
	super(dmg)
	
	if hp > 0:
		$spr_pivot/spr/AnimationPlayer.play("hurt")

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(15)
		curr_scene.camera.shake(0.2, 2)
		
		$spr_pivot/spr/AnimationPlayer.stop()
		$spr_pivot/spr/AnimationPlayer.play("attack")
		
		curr_scene.use_action_point()
		
		await $spr_pivot/spr/AnimationPlayer.animation_finished
		
		return true
