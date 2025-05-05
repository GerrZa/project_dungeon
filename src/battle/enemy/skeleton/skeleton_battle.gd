extends Enemy

func _ready() -> void:
	super()
	
	connect("dead", func():
		remove_self()
		queue_free()
		)

func _physics_process(delta: float) -> void:
	super(delta)
	
	$hp_label.text = var_to_str(hp)
	$name.text = name

func perform_action():
	curr_scene.player_lane[lane].take_damage(15)
	curr_scene.camera.shake(0.2, 4)
	
	$AnimationPlayer.play('attack')
	
	await $AnimationPlayer.animation_finished
	
	super()
