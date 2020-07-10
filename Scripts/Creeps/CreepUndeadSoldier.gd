extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		3:
			value = 7
			max_hitpoints = 15
			speed = 45
		4:
			value = 9
			max_hitpoints = 20
			speed = 50
		5:
			value = 11
			max_hitpoints = 25.5
			speed = 55
		6:
			value = 13
			max_hitpoints = 31
			speed = 60
		7:
			value = 15
			max_hitpoints = 37
			speed = 65
		8:
			value = 18
			max_hitpoints = 43.5
			speed = 70
		9:
			value = 21
			max_hitpoints = 49
			speed = 75
		10:
			value = 25
			max_hitpoints = 56
			speed = 80

