extends Player

var action_list = {
	"Stealll" : attack,
	"WVINKKK" : attack
}

func _physics_process(delta: float) -> void:
	super(delta)

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane].take_damge(15)
		curr_scene.camera.shake(0.4, 8)
		
		curr_scene.player_action_point -= 1
		return true
	else:
		return false
