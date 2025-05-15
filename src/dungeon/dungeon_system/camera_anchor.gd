extends Node2D

@export_node_path("Sprite2D") var party_node : NodePath

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if party_node != null:
		global_position = lerp(global_position, Vector2(200, get_node(party_node).global_position.y), 0.1)
