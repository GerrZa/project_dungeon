@tool
extends ButtonPanel

@export var icon : Texture2D = preload("res://asset/dungeon/empty_icon.png")
@export_multiline var desc = ""
@export var connected_node : Array = []

func _ready() -> void:
	super()
	connect("button_pressed", func(): print("hey"))

func _process(delta: float) -> void:
	super(delta)
	
	size = icon.get_size()
	$Tooltip.size = icon.get_size()
	
	$Tooltip.tip_text = desc
	$Tooltip.icon_texture = icon
	
