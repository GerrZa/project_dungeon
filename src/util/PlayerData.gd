extends Node

var member_info = {
	Global.TYPE.RED : {
		"name" : "[color=#ed4f27]SwordMan[/color]",
		"alive" : true,
		"max_hp" : 100,
		"hp" : 100,
		"weapon" : "regular_sword"
	},
	Global.TYPE.BLUE : {
		"name" : "[color=#56b2b4]Witch[/color]",
		"alive" : true,
		"max_hp" : 100,
		"hp" : 100,
		"weapon" : "regular_sword"
	},
	Global.TYPE.GREEN : {
		"name" : "[color=#c5e857]Theif[/color]",
		"alive" : true,
		"max_hp" : 100,
		"hp" : 100,
		"weapon" : "regular_sword"
	}
}

# weapon template

#[name_id] : {
	#"display" : [display_name],
	#"desc" : [description],
	#"action_list" : {
		#[action_display_name] : [short_description]
	#}
#}

var weapon_list = {
	Global.TYPE.RED : {
		"regular_sword" : {
			"display" : "Filthy Sword",
			"desc" : "Filthy sword for a filthy user.",
			"action_list" : {
				"Slash" : "Deal minimal damage"
			}
		}
	}
}
