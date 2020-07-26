extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		3:
			value = 7
			max_hitpoints = 25
			speed = 50
		4:
			value = 9
			max_hitpoints = 30
			speed = 50
		5:
			value = 11
			max_hitpoints = 35
			speed = 50
		6:
			value = 13
			max_hitpoints = 40
			speed = 55
		7:
			value = 15
			max_hitpoints = 45
			speed = 55
		8:
			value = 18
			max_hitpoints = 50
			speed = 55
		9:
			value = 21
			max_hitpoints = 50
			speed = 60
		10:
			value = 24
			max_hitpoints = 50
			speed = 60
		11:
			value = 27
			max_hitpoints = 55
			speed = 60
		12:
			value = 30
			max_hitpoints = 60
			speed = 65
		13:
			value = 33
			max_hitpoints = 70
			speed = 65
		14:
			value = 37
			max_hitpoints = 80
			speed = 65
		15:
			value = 40
			max_hitpoints = 90
			speed = 70

