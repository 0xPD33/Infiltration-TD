extends "res://Scripts/Creeps/CreepBaseTank.gd"


func _ready():
	randomize()
	setup_stats()


func setup_stats():
	match Global.wave:
		11:
			value = 30
			max_hitpoints = stepify(rand_range(175, 200), 0.1)
			speed = 45
		12:
			value = 32
			max_hitpoints = stepify(rand_range(200, 220), 0.1)
			speed = 50
		13:
			value = 34
			max_hitpoints = stepify(rand_range(220, 240), 0.1)
			speed = 55
		14:
			value = 36
			max_hitpoints = stepify(rand_range(240, 260), 0.1)
			speed = 60
		15:
			value = 38
			max_hitpoints = stepify(rand_range(260, 280), 0.1)
			speed = 60
