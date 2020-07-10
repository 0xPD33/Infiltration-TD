extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		0:
			value = 0
			max_hitpoints = 0
			speed = 0
		1:
			value = 2
			max_hitpoints = 2
			speed = 70
		2:
			value = 3
			max_hitpoints = 3.5
			speed = 73
		3:
			value = 4
			max_hitpoints = 5
			speed = 76
		4:
			value = 6
			max_hitpoints = 7.7
			speed = 80
		5:
			value = 8
			max_hitpoints = 10
			speed = 85
		6:
			value = 10
			max_hitpoints = 13.5
			speed = 90
		7:
			value = 12
			max_hitpoints = 16.5
			speed = 95
		8:
			value = 14
			max_hitpoints = 20
			speed = 100
		9:
			value = 17
			max_hitpoints = 25
			speed = 105
		10:
			value = 20
			max_hitpoints = 30
			speed = 110

