extends "res://Scripts/Projectiles/TurretProjectile.gd"


func _ready():
	randomize()
	damage = stepify(rand_range(2, 2.5), 0.01)
	speed = 325

