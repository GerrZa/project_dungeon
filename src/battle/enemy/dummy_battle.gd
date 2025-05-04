extends MouseDetectArea2D

var to_pos = Vector2.ZERO
var lane = 0

var hp = 100

enum {
	ORANGE,
	BLUE,
	GREEN
}

var weak = ORANGE

func _ready() -> void:
	super()
	
	randomize()
	
	weak = randi_range(0,2)

func _physics_process(delta: float) -> void:
	position = lerp(position, to_pos, 0.1)
	
	$hp_label.text = "hp: " + var_to_str(hp)
	
	match weak:
		ORANGE:
			$weak_ind.color = Color.ORANGE_RED
		BLUE:
			$weak_ind.color = Color.TEAL
		GREEN:
			$weak_ind.color = Color.SEA_GREEN

func take_damage(dmg, type):
	if type == weak:
		dmg *= 2
	
	hp -= dmg
	
	if hp < 1:
		queue_free()
		get_tree().current_scene.enemy_lane[lane].erase(self)
		get_tree().current_scene.rearrange_ene()

func attack(dmg):
	get_tree().current_scene.player_lane[lane].hp -= dmg

func swapdown():
	if lane <= 0:
		return
	
	get_tree().current_scene.enemy_lane[lane].erase(self)
	
	lane -= 1
	
	get_tree().current_scene.enemy_lane[lane].append(self)
	
	get_tree().current_scene.rearrange_ene()

func swapup():
	if lane >= 2:
		return
	
	get_tree().current_scene.enemy_lane[lane].erase(self)
	
	lane += 1
	
	get_tree().current_scene.enemy_lane[lane].append(self)
	
	get_tree().current_scene.rearrange_ene()
