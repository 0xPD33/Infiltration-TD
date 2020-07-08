extends "res://Scripts/Creeps/Creep.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		0:
			value = 0
			hitpoints = 0
			speed = 0
		1:
			value = 2
			hitpoints = 3.0
			speed = 70
		2:
			value = 4
			hitpoints = 5.0
			speed = 75
		3:
			value = 6
			hitpoints = 7.0
			speed = 80
		4:
			value = 8
			hitpoints = 9.0
			speed = 85
		5:
			value = 10
			hitpoints = 11.0
			speed = 90
		6:
			value = 12
			hitpoints = 13.0
			speed = 95
		7:
			value = 14
			hitpoints = 15.0
			speed = 100
		8:
			value = 16
			hitpoints = 17.0
			speed = 105
		9:
			value = 18
			hitpoints = 19.0
			speed = 110
		10:
			value = 20
			hitpoints = 21.5
			speed = 115

