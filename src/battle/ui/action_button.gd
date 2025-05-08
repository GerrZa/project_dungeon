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
	
	var render_modulate = Color.WHITE
	
	$anchor/RichTextLabel.text = text
	
	if mouse_in:
		render_modulate.v = 1
	else:
		render_modulate.v = 0.8
	
	if pressing:
		render_modulate.v = 0.5
	
	if disable:
		render_modulate.v = 0.5
	
	$anchor.modulate = render_modulate
	
	$anchor.z_index = anchor_z_index

func _physics_process(delta: float) -> void:
	if smoothing:
		$anchor.global_position = lerp($anchor.global_position, global_position, 0.4)
	else:
		$anchor.global_position = $anchor.global_position
