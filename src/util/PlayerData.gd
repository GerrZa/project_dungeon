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

var weapon_detail = {
	"regular_sword" : {
		"display" : "Regular Sword",
		"desc" : "Regular sword that so cheap, they give away to newbie for free.",
		"action_list" : {
			"Slash" : "Deal minimal damage",
			"Block" : "Create shield that substact incoming damages\nonly last for 1 turn."
		}
	}
}
