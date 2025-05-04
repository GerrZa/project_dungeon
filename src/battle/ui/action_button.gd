@tool
extends ButtonPanel

func _process(delta: float) -> void:
	super(delta)
	
	$anchor/RichTextLabel.text = text
	
	if mouse_in:
		modulate.v = 1
	else:
		modulate.v = 0.8
	
	if pressing:
		modulate.v = 0.5
