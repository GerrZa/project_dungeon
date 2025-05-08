@tool
extends NinePatchRect

var progress
var mouse_in = false

@export var value_name = "N/A"
@export var max_value = 100
@export var value = 100

@export var show_text = true

@export var show_name = true
@export var show_as_percentage = false

@export var slow_bar = false

func _ready() -> void:
	connect("mouse_entered", func(): mouse_in = true)
	connect("mouse_exited", func(): mouse_in = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if show_text:
		if show_name:
			if show_as_percentage:
				$tooltip.text = "{0}: {1.2f}%".format([value_name, value/max_value])
			else:
				$tooltip.text = "{0}: {1}/{2}".format([value_name, int(round(value)), int(round(max_value))])
		else:
			$tooltip.text = "{1}/{2}".format([value_name, int(round(value)), int(round(max_value))])
	else:
		$tooltip.text = ""
		
	
	
	$tooltip.visible = mouse_in
	
	value = clamp(value, 0, max_value)
	
	$bar.scale.x = value/float(max_value)


func _physics_process(delta: float) -> void:
	if slow_bar:
		$slow_bar.visible = true
		$slow_bar.scale.x = lerp($slow_bar.scale.x, $bar.scale.x, 0.1)
	else:
		$slow_bar.visible = false

func change_value(new_value):
	value = new_value
	$bar.scale.x = value / float(max_value)

func adjust_value(diff):
	value += diff
	$bar.scale.x = value / float(max_value)

func reset_value(new_value, new_max_value):
	value = new_value
	max_value = new_max_value
	
	$bar.scale.x = value / float(max_value)
	$slow_bar.scale.x = $bar.scale.x
