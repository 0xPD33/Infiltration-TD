extends "res://Scripts/Projectiles/TurretProjectile.gd"


func _ready():
	damage = stepify(rand_range(4.7, 5.6), 0.01)
	speed = 450

