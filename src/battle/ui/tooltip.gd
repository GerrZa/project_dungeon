@tool
extends Panel

var mouse_in = false
@export_multiline var tip_text : String = ""
@export var icon_texture : Texture2D = null
@export var editor_show_text = true

var follow_target = null
var follow_offset = Vector2.ZERO

@export var text_margin := Vector2(8.0, 3.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mouse_entered", func() : mouse_in = true)
	connect("mouse_exited", func() : mouse_in = false)
	
	$info_pivot.visible = false

func _physics_process(delta: float) -> void:
	$Icon.material.set_shader_parameter("active", mouse_in)
	
	self_modulate = Color(0,0,0,0)
	
	if follow_target != null:
		global_position = follow_target.position + follow_offset
	
	$info_pivot/RichTextLabel.text = tip_text
	$info_pivot/RichTextLabel.size = load("res://asset/place_holder/SmolFont.ttf").get_multiline_string_size($info_pivot/RichTextLabel.get_parsed_text(), 0, -1, 8, -1, 3, 3, 0, 0) + Vector2(round(text_margin.x), round(text_margin.y))
	
	$info_pivot/NinePatchRect.size = $info_pivot/RichTextLabel.size
	
	$info_pivot/RichTextLabel.position = Vector2(0, -$info_pivot/RichTextLabel.size.y)
	$info_pivot/NinePatchRect.position = $info_pivot/RichTextLabel.position
	
	$Icon.texture = icon_texture
	
	$info_pivot.visible = true
	
	if Engine.is_editor_hint():
		$info_pivot.global_position = global_position
		if editor_show_text == false:
			$info_pivot.visible = false
		return
	
	$info_pivot.global_position = get_global_mouse_position()
	
	if mouse_in:
		$info_pivot.global_position = get_global_mouse_position()
		$info_pivot.visible = true
	else:
		$info_pivot.visible = false
	
	$info_pivot.global_position.x = clamp($info_pivot.global_position.x, 0, 400 - $info_pivot/NinePatchRect.size.x)
	$info_pivot.global_position.y = clamp($info_pivot.global_position.y, 0, 300 - $info_pivot/NinePatchRect.size.y)
