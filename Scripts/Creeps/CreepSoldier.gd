extends "res://Scripts/Creeps/CreepBase.gd"


func _ready():
	randomize()
	setup_stats()


func setup_stats():
	match Global.wave:
		0:
			value = 0
			max_hitpoints = 0
			speed = 0
		1:
			value = 2
			max_hitpoints = stepify(rand_range(1.5, 2.5), 0.1)
			speed = 60
		2:
			value = 3
			max_hitpoints = stepify(rand_range(2.5, 3.5), 0.1)
			speed = 63
		3:
			value = 4
			max_hitpoints = stepify(rand_range(3.5, 4.5), 0.1)
			speed = 66
		4:
			value = 5
			max_hitpoints = stepify(rand_range(4.5, 5.5), 0.1)
			speed = 70
		5:
			value = 7
			max_hitpoints = stepify(rand_range(6, 7.5), 0.1)
			speed = 75
		6:
			value = 8
			max_hitpoints = stepify(rand_range(8, 10), 0.1)
			speed = 80
		7:
			value = 9
			max_hitpoints = stepify(rand_range(10, 12), 0.1)
			speed = 85
		8:
			value = 10
			max_hitpoints = stepify(rand_range(12, 15), 0.1)
			speed = 90
		9:
			value = 11
			max_hitpoints = stepify(rand_range(15, 18), 0.1)
			speed = 95
		10:
			value = 12
			max_hitpoints = stepify(rand_range(18, 21), 0.1)
			speed = 100
		11:
			value = 13
			max_hitpoints = stepify(rand_range(21, 24), 0.1)
			speed = 100
		12:
			value = 14
			max_hitpoints = stepify(rand_range(23.5, 27), 0.1)
			speed = 100
		13:
			value = 15
			max_hitpoints = stepify(rand_range(28, 31), 0.1)
			speed = 100
		14:
			value = 17
			max_hitpoints = stepify(rand_range(32, 35), 0.1)
			speed = 100
		15:
			value = 20
			max_hitpoints = stepify(rand_range(37.5, 42.5), 0.1)
			speed = 100

