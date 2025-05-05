@tool
extends ButtonPanel

func _process(delta: float) -> void:
	super(delta)
	
	$anchor/RichTextLabel.text = text
	
	modulate = Color.WHITE
	
	if mouse_in:
		modulate.v = 1
	else:
		modulate.v = 0.8
		
	if pressing:
		modulate.v = 0.5
	
	if disable:
		modulate.v = 0.5
