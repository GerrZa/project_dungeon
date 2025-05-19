@tool
extends RoomNode

func perform_node():
	var fade_anim = get_tree().current_scene.get_node("fader/fader_rect/AnimationPlayer")
	
	fade_anim.play("half_in")
	
	await fade_anim.animation_finished
	
	
