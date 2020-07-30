extends "res://Scripts/Projectiles/SniperProjectile.gd"


func _ready():
	damage = stepify(rand_range(24.5, 27.5), 0.01)
	speed = 850

