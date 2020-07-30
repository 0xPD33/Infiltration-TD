extends "res://Scripts/Projectiles/TurretProjectile.gd"


func _ready():
	damage = stepify(rand_range(9.5, 14), 0.01)
	speed = 550

