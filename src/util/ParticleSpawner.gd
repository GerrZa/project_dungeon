extends Node

enum PARTS{
	FLOATING_TEXT,
	
}

var lib = {
	PARTS.FLOATING_TEXT : {
		"file" : load("uid://bkxw0tfamxa7e")
	}
}

func spawn(part : PARTS, target : Node2D, arg = []):
	var ins = lib[part]["file"].instantiate()
	
	ins.initialize.callv(arg)
	
	target.add_child(ins)
