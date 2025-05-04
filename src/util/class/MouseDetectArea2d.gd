extends Area2D
class_name MouseDetectArea2D

var mouse_in = false

func _ready() -> void:
	connect("mouse_entered", func(): mouse_in = true)
	connect("mouse_exited", func(): mouse_in = false)
