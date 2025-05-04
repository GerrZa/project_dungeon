extends Player

var action_list = {
	"Slash" : attack
}

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(15)
		curr_scene.camera.shake(0.2, 2)
		
		$AnimationPlayer.stop()
		$AnimationPlayer.play("attack")
		
		curr_scene.player_action_point -= 1
		return true
	else:
		return false
