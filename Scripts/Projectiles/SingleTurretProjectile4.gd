extends "res://Scripts/Projectiles/TurretProjectile.gd"


func _ready():
	randomize()
	damage = stepify(rand_range(4.5, 5.5), 0.01)
	speed = 425

