extends Enemy


func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)

func perform_action():
	curr_scene.player_lane[lane].take_damage(15)
	
	super()
