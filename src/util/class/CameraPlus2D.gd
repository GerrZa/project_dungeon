class_name CameraPlus2D
extends Camera2D

var shake_t_ceil = 0.0 #for instensitiy calculation
var shake_t_left = 0.0
var shake_instense = 0.0

func _process(delta: float) -> void:
	offset = Vector2.ZERO
	
	if shake_t_left > 0.0:
		randomize()
		var random_dir = randf_range(0, PI*2)
		
		offset = Vector2(shake_instense * (shake_t_left / shake_t_ceil) * cos(random_dir), shake_instense * (shake_t_left / shake_t_ceil) * sin(random_dir))
		
		shake_t_left -= delta
		
		if shake_t_left < 0:
			shake_t_left = 0.0
	

func shake(duration, instensity):
	shake_instense = instensity
	shake_t_ceil = duration
	shake_t_left = duration
