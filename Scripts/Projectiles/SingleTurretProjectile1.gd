extends "res://Scripts/Projectiles/TurretProjectile.gd"


func _ready():
	randomize()
	damage = stepify(rand_range(0.8, 1.25), 0.01)
	speed = 300

