extends "res://Scripts/Creeps/CreepBase.gd"


func _ready():
	randomize()
	setup_stats()


func setup_stats():
	match Global.wave:
		4:
			value = 5
			max_hitpoints = stepify(rand_range(10, 15), 0.1)
			speed = 80
		5:
			value = 6
			max_hitpoints = stepify(rand_range(12, 18), 0.1)
			speed = 80
		6:
			value = 7
			max_hitpoints = stepify(rand_range(14, 20), 0.1)
			speed = 80
		7:
			value = 8
			max_hitpoints = stepify(rand_range(16, 21), 0.1)
			speed = 90
		8:
			value = 9
			max_hitpoints = stepify(rand_range(18, 23), 0.1)
			speed = 90
		9:
			value = 10
			max_hitpoints = stepify(rand_range(20, 25), 0.1)
			speed = 90
		10:
			value = 12
			max_hitpoints = stepify(rand_range(22, 27), 0.1)
			speed = 100
		11:
			value = 14
			max_hitpoints = stepify(rand_range(25, 30), 0.1)
			speed = 100
		12:
			value = 16
			max_hitpoints = stepify(rand_range(27, 32), 0.1)
			speed = 100
		13:
			value = 18
			max_hitpoints = stepify(rand_range(29, 34), 0.1)
			speed = 110
		14:
			value = 20
			max_hitpoints = stepify(rand_range(32, 38), 0.1)
			speed = 115
		15:
			value = 22
			max_hitpoints = stepify(rand_range(35, 40), 0.1)
			speed = 120

