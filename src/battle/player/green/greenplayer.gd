extends Player

var action_list = {
	"Stealll" : {"call" : attack, "cond" : func(): return true},
	"WVINKKK" : {"call" : attack, "cond" : func(): return true}
}

func _physics_process(delta: float) -> void:
	super(delta)
	$lane_label.text = var_to_str(lane)

func attack():
	if curr_scene.enemy_lane[lane].size() > 0:
		curr_scene.enemy_lane[lane][0].take_damage(15)
		curr_scene.camera.shake(0.3, 4)
		
		curr_scene.use_action_point()
		
		return true
