extends "res://Scripts/Creeps/CreepBase.gd"


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
			max_hitpoints = 4
			speed = 66
		4:
			value = 5
			max_hitpoints = 5
			speed = 70
		5:
			value = 7
			max_hitpoints = 7
			speed = 75
		6:
			value = 8
			max_hitpoints = 10
			speed = 80
		7:
			value = 9
			max_hitpoints = 12
			speed = 85
		8:
			value = 10
			max_hitpoints = 15
			speed = 90
		9:
			value = 12
			max_hitpoints = 18
			speed = 95
		10:
			value = 14
			max_hitpoints = 21
			speed = 100
		11:
			value = 16
			max_hitpoints = 24
			speed = 105
		12:
			value = 18
			max_hitpoints = 27
			speed = 110
		13:
			value = 20
			max_hitpoints = 30
			speed = 110
		14:
			value = 22
			max_hitpoints = 33
			speed = 110
		15:
			value = 25
			max_hitpoints = 40
			speed = 110

