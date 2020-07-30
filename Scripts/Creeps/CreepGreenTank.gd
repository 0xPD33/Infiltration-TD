extends "res://Scripts/Creeps/CreepBaseTank.gd"


func _ready():
	setup_stats()


func setup_stats():
	match Global.wave:
		5:
			value = 15
			max_hitpoints = 80
			speed = 30
		6:
			value = 16
			max_hitpoints = 85
			speed = 32
		7:
			value = 17
			max_hitpoints = 90
			speed = 34
		8:
			value = 18
			max_hitpoints = 95
			speed = 37
		9:
			value = 19
			max_hitpoints = 100
			speed = 40
		10:
			value = 20
			max_hitpoints = 105
			speed = 43
		11:
			value = 25
			max_hitpoints = 130
			speed = 50
		12:
			value = 30
			max_hitpoints = 140
			speed = 55
		13:
			value = 35
			max_hitpoints = 155
			speed = 55
		14:
			value = 42
			max_hitpoints = 175
			speed = 55
		15:
			value = 50
			max_hitpoints = 200
			speed = 55

