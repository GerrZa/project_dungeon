class_name ButtonPanel
extends Panel

signal button_pressed
var pressing = false
var mouse_in = false
var debug_mouse_in = false
@export var disable = true
@export var oneshot = true

@export_multiline var text := ""

func _ready() -> void:
	connect("mouse_entered", func(): debug_mouse_in = true)
	connect("mouse_exited", func(): debug_mouse_in = false)
	
	self_modulate = Color(0,0,0,0)

func _process(delta: float) -> void:
	if disable == false:
		mouse_in = debug_mouse_in
		
		if mouse_in and Input.is_action_just_pressed("m1"):
			pressing = true
		
		if pressing and Input.is_action_just_released("m1"):
			if mouse_in:
				pressing = false
				emit_signal("button_pressed")
				if oneshot:
					disable = true
			else:
				pressing = false
	else:
		mouse_in = false
		pressing = false
