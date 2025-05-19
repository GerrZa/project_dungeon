@tool
extends ButtonPanel

@export var smoothing := true
@export var anchor_z_index := 0

func _ready() -> void:
	$anchor.top_level = true
	$anchor.global_position = global_position
	super()

func _process(delta: float) -> void:
	super(delta)
	
	var render_modulate = 1.0
	
	$anchor/RichTextLabel.text = text
	
	if mouse_in:
		render_modulate = 1.2
	
	if pressing:
		render_modulate = 0.5
	
	if disable:
		render_modulate = 0.5
	
	$anchor/PttButton.material.set_shader_parameter("bri", lerp($anchor/PttButton.material.get_shader_parameter("bri"), render_modulate, 0.5))
	
	var mod_col = Color.WHITE
	mod_col.v = render_modulate
	
	$anchor.modulate = mod_col
	
	$anchor.z_index = anchor_z_index

func _physics_process(delta: float) -> void:
	if smoothing:
		$anchor.global_position = lerp($anchor.global_position, global_position, 0.4)
	else:
		$anchor.global_position = $anchor.global_position
