extends Enemy

var will_escape = false

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
	
	$spr_anchor/spr.material.set_shader_parameter("active", false)
	
	for i in $tooltips.get_children():
		if i.mouse_in:
			$spr_anchor/spr.material.set_shader_parameter("active", true)
			break

func take_damage(dmg):
	super(dmg)
	
	if hp <= 30:
		will_escape = true
		$tooltips/runaway.visible = true

func perform_action():
	if will_escape == false:
		curr_scene.player_lane[lane].take_damage(15)
		curr_scene.camera.shake(0.2, 4)
		
		$AnimationPlayer.play('attack')
		
		await $AnimationPlayer.animation_finished
		
		super()
	else:
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
		
		tween.tween_property(self, "global_position", Vector2(450, global_position.y), 0.2)
		
		await tween.finished
		
		super()
		
		follow_to_pos = false
		
		remove_self()
		print("remove")
		queue_free()
