extends "res://Scripts/Projectiles/TurretProjectile.gd"


func _ready():
	damage = stepify(rand_range(5.5, 8.5), 0.01)
	speed = 500

