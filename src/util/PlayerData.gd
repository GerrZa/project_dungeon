extends Node

var member_info = {
	Global.TYPE.RED : {
		"alive" : true,
		"max_hp" : 100,
		"hp" : 100,
		"weapon" : "regular_sword"
	},
	Global.TYPE.BLUE : {
		"alive" : true,
		"max_hp" : 100,
		"hp" : 100,
		"weapon" : "regular_sword"
	},
	Global.TYPE.GREEN : {
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
		"filthy_sword" : {
			"display" : "Filthy Sword",
			"desc" : "Filthy sword for a filthy user.",
			"action_list" : {
				"Slash" : "Deal minimal damage"
			}
		}
	}
}
