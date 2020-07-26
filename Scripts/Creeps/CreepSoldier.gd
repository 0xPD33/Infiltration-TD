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
			speed = 60
		2:
			value = 3
			max_hitpoints = 3
			speed = 63
		3:
			value = 4
			max_hitpoints = 5
			speed = 66
		4:
			value = 6
			max_hitpoints = 7
			speed = 70
		5:
			value = 8
			max_hitpoints = 9
			speed = 75
		6:
			value = 10
			max_hitpoints = 11
			speed = 80
		7:
			value = 12
			max_hitpoints = 13
			speed = 85
		8:
			value = 14
			max_hitpoints = 15
			speed = 90
		9:
			value = 17
			max_hitpoints = 17
			speed = 95
		10:
			value = 20
			max_hitpoints = 20
			speed = 100
		11:
			value = 23
			max_hitpoints = 23
			speed = 105
		12:
			value = 26
			max_hitpoints = 26
			speed = 110
		13:
			value = 28
			max_hitpoints = 28
			speed = 110
		14:
			value = 30
			max_hitpoints = 30
			speed = 110
		15:
			value = 30
			max_hitpoints = 30
			speed = 110

