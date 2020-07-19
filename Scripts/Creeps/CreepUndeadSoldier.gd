extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		3:
			value = 7
			max_hitpoints = 16
			speed = 35
		4:
			value = 9
			max_hitpoints = 20
			speed = 40
		5:
			value = 11
			max_hitpoints = 24
			speed = 45
		6:
			value = 13
			max_hitpoints = 28
			speed = 50
		7:
			value = 15
			max_hitpoints = 33
			speed = 52
		8:
			value = 18
			max_hitpoints = 40
			speed = 54
		9:
			value = 21
			max_hitpoints = 48
			speed = 56
		10:
			value = 25
			max_hitpoints = 57
			speed = 58
		11:
			value = 29
			max_hitpoints = 67
			speed = 60
		12:
			value = 35
			max_hitpoints = 80
			speed = 65

