extends Control

@export var gap := 8
@export var item_size := Vector2(12,12)

func _ready() -> void:
	sort()


func sort():
	var sum_size_x = (get_child_count() * item_size.x) + ((get_child_count()-1) * gap)
	var start_point = (size.x - sum_size_x) / 2
	
	var j = 0
	
	for i in get_children():
		i.position.y = (size.y/2) - (item_size.y/2)
		
		i.position.x = start_point + ((item_size.x + gap) * j)
		
		j+=1
