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
			max_hitpoints = 3
			speed = 70
		2:
			value = 3
			max_hitpoints = 5
			speed = 75
		3:
			value = 4
			max_hitpoints = 7
			speed = 80
		4:
			value = 5
			max_hitpoints = 9
			speed = 85
		5:
			value = 7
			max_hitpoints = 12
			speed = 90
		6:
			value = 9
			max_hitpoints = 15
			speed = 95
		7:
			value = 11
			max_hitpoints = 18
			speed = 100
		8:
			value = 13
			max_hitpoints = 21.5
			speed = 105
		9:
			value = 15
			max_hitpoints = 25
			speed = 110
		10:
			value = 18
			max_hitpoints = 29
			speed = 115

