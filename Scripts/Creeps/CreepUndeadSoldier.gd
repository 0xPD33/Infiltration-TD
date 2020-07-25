extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		3:
			value = 5
			max_hitpoints = 20
			speed = 50
		4:
			value = 8
			max_hitpoints = 23
			speed = 50
		5:
			value = 11
			max_hitpoints = 26
			speed = 50
		6:
			value = 14
			max_hitpoints = 29
			speed = 55
		7:
			value = 17
			max_hitpoints = 33
			speed = 55
		8:
			value = 20
			max_hitpoints = 37
			speed = 55
		9:
			value = 23
			max_hitpoints = 42
			speed = 60
		10:
			value = 26
			max_hitpoints = 47
			speed = 60
		11:
			value = 29
			max_hitpoints = 53
			speed = 60
		12:
			value = 32
			max_hitpoints = 60
			speed = 65
		13:
			value = 35
			max_hitpoints = 70
			speed = 65
		14:
			value = 38
			max_hitpoints = 80
			speed = 65
		15:
			value = 41
			max_hitpoints = 90
			speed = 70

