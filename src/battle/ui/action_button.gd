@tool
extends ButtonPanel

func _ready() -> void:
	$anchor.top_level = true
	$anchor.global_position = global_position
	super()

func _process(delta: float) -> void:
	super(delta)
	
	$anchor/RichTextLabel.text = text
	
	$anchor.modulate = Color.WHITE
	
	if mouse_in:
		$anchor.modulate.v = 1
	else:
		$anchor.modulate.v = 0.8
	
	if pressing:
		$anchor.modulate.v = 0.5
	
	if disable:
		$anchor.modulate.v = 0.5

func _physics_process(delta: float) -> void:
	$anchor.global_position = lerp($anchor.global_position, global_position, 0.3)
