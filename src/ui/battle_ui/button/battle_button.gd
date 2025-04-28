class_name BattleButton
extends Area2D

var mouse_in = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mouse_entered", func(): mouse_in = true)
	connect("mouse_exited", func(): mouse_in = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_in:
		$idle_spr.visible = false
		$hover_spr.visible = true
	else:
		$idle_spr.visible = true
		$hover_spr.visible = false
