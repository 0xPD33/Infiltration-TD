extends "res://Scripts/Projectiles/SniperProjectile.gd"


func _ready():
	damage = stepify(rand_range(14, 16), 0.01)
	speed = 750

