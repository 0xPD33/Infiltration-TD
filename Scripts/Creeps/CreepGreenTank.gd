extends "res://Scripts/Creeps/CreepBaseTank.gd"


func _ready():
	randomize()
	setup_stats()


func setup_stats():
	match Global.wave:
		5:
			value = 15
			max_hitpoints = stepify(rand_range(70, 80), 0.1)
			speed = 30
		6:
			value = 16
			max_hitpoints = stepify(rand_range(75, 85), 0.1)
			speed = 32
		7:
			value = 17
			max_hitpoints = stepify(rand_range(80, 90), 0.1)
			speed = 34
		8:
			value = 18
			max_hitpoints = stepify(rand_range(85, 95), 0.1)
			speed = 37
		9:
			value = 19
			max_hitpoints = stepify(rand_range(90, 100), 0.1)
			speed = 40
		10:
			value = 20
			max_hitpoints = stepify(rand_range(95, 110), 0.1)
			speed = 43
		11:
			value = 22
			max_hitpoints = stepify(rand_range(100, 120), 0.1)
			speed = 50
		12:
			value = 24
			max_hitpoints = stepify(rand_range(120, 140), 0.1)
			speed = 55
		13:
			value = 26
			max_hitpoints = stepify(rand_range(150, 180), 0.1)
			speed = 55
		14:
			value = 28
			max_hitpoints = stepify(rand_range(180, 210), 0.1)
			speed = 55
		15:
			value = 30
			max_hitpoints = stepify(rand_range(200, 250), 0.1)
			speed = 55

