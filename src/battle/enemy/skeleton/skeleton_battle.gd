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
	
	for i in $CanvasLayer/tooltips.get_children():
		if i.mouse_in:
			$spr_anchor/spr.material.set_shader_parameter("active", true)
			break

func _process(delta: float) -> void:
	$CanvasLayer/tooltips.global_position = global_position - Vector2(-8, 49) - curr_scene.camera.global_position - curr_scene.camera.offset
	$CanvasLayer/tooltips/runaway.visible = will_escape

func take_damage(dmg, type):
	super(dmg, type)
	
	if weak == type:
		dmg = int(round(dmg * weak_amp))
		
		$AnimationPlayer.stop()
		$AnimationPlayer.play("weak_hurt")
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hurt")
	
	ParticleSpawner.spawn(ParticleSpawner.PARTS.FLOATING_TEXT, curr_scene, [global_position - Vector2(0, 30), var_to_str(dmg), true, Color.RED, 50.0, 0.65, true, 2])
	
	
	if hp <= 30:
		will_escape = true
		$CanvasLayer/tooltips/runaway.visible = true

func perform_action():
	if will_escape == false:
		curr_scene.player_lane[lane].take_damage(15)
		curr_scene.camera.shake(0.2, 4)
		
		$AnimationPlayer.stop()
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

func spr_flash(value : bool):
	$spr_anchor/spr.material.set_shader_parameter("flashing_enable", value)

func spr_flash_set_color(color : Color):
	$spr_anchor/spr.material.set_shader_parameter("flashing_color", color)
