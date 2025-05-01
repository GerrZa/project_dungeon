extends MouseDetectArea2D

var to_pos = Vector2.ZERO
var lane = 0

var hp = 100

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	position = lerp(position, to_pos, 0.1)
	
	$hp_label.text = "hp: " + var_to_str(hp)

func take_damage(dmg):
	hp -= dmg
	
	if hp < 1:
		queue_free()
		get_tree().current_scene.enemy_lane[lane].erase(self)
		get_tree().current_scene.rearrange_ene()
