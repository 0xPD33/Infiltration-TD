extends "res://Scripts/Creeps/CreepBase.gd"


func _ready():
	randomize()
	setup_stats()


func setup_stats():
	match Global.wave:
		3:
			value = 6
			max_hitpoints = stepify(rand_range(20, 30), 0.1)
			speed = 50
		4:
			value = 8
			max_hitpoints = stepify(rand_range(30, 40), 0.1)
			speed = 50
		5:
			value = 10
			max_hitpoints = stepify(rand_range(40, 50), 0.1)
			speed = 50
		6:
			value = 12
			max_hitpoints = stepify(rand_range(50, 55), 0.1)
			speed = 55
		7:
			value = 14
			max_hitpoints = stepify(rand_range(55, 60), 0.1)
			speed = 55
		8:
			value = 16
			max_hitpoints = stepify(rand_range(55, 65), 0.1)
			speed = 55
		9:
			value = 18
			max_hitpoints = stepify(rand_range(60, 70), 0.1)
			speed = 60
		10:
			value = 20
			max_hitpoints = stepify(rand_range(65, 70), 0.1)
			speed = 60
		11:
			value = 21
			max_hitpoints = stepify(rand_range(65, 75), 0.1)
			speed = 60
		12:
			value = 22
			max_hitpoints = stepify(rand_range(70, 80), 0.1)
			speed = 65
		13:
			value = 23
			max_hitpoints = stepify(rand_range(80, 90), 0.1)
			speed = 65
		14:
			value = 24
			max_hitpoints = stepify(rand_range(85, 95), 0.1)
			speed = 65
		15:
			value = 25
			max_hitpoints = stepify(rand_range(90, 100), 0.1)
			speed = 70

