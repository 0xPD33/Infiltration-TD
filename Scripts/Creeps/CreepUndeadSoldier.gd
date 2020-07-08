extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		3:
			value = 7
			hitpoints = 17.5
			speed = 45
		4:
			value = 9
			hitpoints = 22.5
			speed = 50
		5:
			value = 11
			hitpoints = 27.5
			speed = 55
		6:
			value = 13
			hitpoints = 32.5
			speed = 60
		7:
			value = 15
			hitpoints = 37.5
			speed = 65
		8:
			value = 18
			hitpoints = 42.5
			speed = 70
		9:
			value = 21
			hitpoints = 47.5
			speed = 75
		10:
			value = 25
			hitpoints = 55.0
			speed = 80

