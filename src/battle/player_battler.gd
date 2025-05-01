extends MouseDetectArea2D

@export var lane = 0

enum TYPE{
	ORANGE,
	BLUE,
	GREEN
}
@export var char_type : TYPE = TYPE.ORANGE

var hp = 100

var to_pos = Vector2.ZERO
@onready var battle_scene = get_tree().current_scene

var action_list = {
	"Party":{
		"Swap": null,
		"Heal": func(plr): plr.hp += 20
	}
}

func _ready() -> void:
	super()
	to_pos = position
	
	match char_type:
		TYPE.ORANGE:
			action_list["Ability"] = {
				"1": null,
				"2": null,
			}
			
			$Char.modulate = Color.ORANGE_RED
		TYPE.BLUE:
			action_list["Ability"] = {
				"3": null,
				"4": null,
			}
			
			$Char.modulate = Color.TEAL
		TYPE.GREEN:
			action_list["Ability"] = {
				"5": null,
				"6": null,
			}
			
			$Char.modulate = Color.SEA_GREEN

func _physics_process(delta: float) -> void:
	if get_tree().current_scene.player_lane.has(self) == false:
		battle_scene.player_lane[lane] = self

func _process(delta: float) -> void:
	position = lerp(position, to_pos, 0.1)
	battle_scene = get_tree().current_scene
	
	print()
