@tool
extends "res://src/battle/ui/tooltip.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super(delta)
	
	if Engine.is_editor_hint():
		return
	match owner.weak:
		Global.TYPE.RED:
			$Icon.frame = 0
			
			tip_text = "[color=OrangeRed][SwordMan][/color] will deal more\ndamage on this unit"
		Global.TYPE.BLUE:
			$Icon.frame = 1
			
			tip_text = "[color=RoyalBlue][Witch][/color] will deal more\ndamage on this unit"
		Global.TYPE.GREEN:
			$Icon.frame = 2
			
			tip_text = "[color=YellowGreen][Thief][/color] will deal more\ndamage on this unit"
