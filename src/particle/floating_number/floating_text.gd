extends Node2D

var text_centered = true
var text = ""
var text_color = Color.WHITE
var text_speed := 20.0
var max_text_life := 1.0
var text_life := 1.0
var text_smoothing = true

func initialize(new_position, text ="HelloWorld", centered = true, color = Color.WHITE, speed = 20.0, life = 1.0, smoothing = true, font_scale := 1):
	global_position = new_position
	
	var size = load("res://asset/place_holder/SmolFont.ttf").get_multiline_string_size($RichTextLabel.get_parsed_text(), 0, -1, 8 * font_scale, -1, 3, 3, 0, 0) + Vector2(2,2)
	
	$RichTextLabel.size = size
	
	if text_centered:
		$RichTextLabel.position = -size/2
	else:
		$RichTextLabel.position = Vector2.ZERO
	
	text_speed = speed
	
	max_text_life = life
	text_life = life
	
	$RichTextLabel.text = text
	$RichTextLabel.add_theme_color_override("default_color", color)
	$RichTextLabel.add_theme_font_size_override("normal_font_size", font_scale * 8)

func _physics_process(delta: float) -> void:
	if text_smoothing:
		global_position.y -= text_speed * delta
		text_speed = lerp(text_speed, max_text_life * 0.1, 0.05)
	else:
		global_position.y -= text_speed * delta
	
	text_life -= delta
	
	if text_life < 0.0:
		queue_free()
	
	modulate.a = clamp((text_life / (max_text_life/2.0)), 0.0, 1.0)
	
