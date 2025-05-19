extends CanvasLayer

var can_click = false

func _ready():
	$NinePatchRect/AnimationPlayer.play("open")
	
	can_click = true
