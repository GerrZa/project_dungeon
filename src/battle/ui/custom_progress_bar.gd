@tool
extends NinePatchRect

var progress
var mouse_in = false

@export var value_name = "N/A"
@export var max_value = 100
@export var value = 100

@export var show_name = true
@export var show_as_percentage = false

func _ready() -> void:
	connect("mouse_entered", func(): mouse_in = true)
	connect("mouse_exited", func(): mouse_in = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if show_name:
		if show_as_percentage:
			$tooltip.text = "{0}: {1.2f}%".format([value_name, value/max_value])
		else:
			$tooltip.text = "{0}: {1}/{2}".format([value_name, value, max_value])
	else:
		$tooltip.text = "{1}/{2}".format([value_name, value, max_value])
		
	
	$tooltip.visible = mouse_in
	
	value = clamp(value, 0, max_value)
	
	$bar.scale.x = value/float(max_value)
