extends "res://Scripts/Projectiles/SniperProjectile.gd"


func _ready():
	randomize()
	damage = stepify(rand_range(14, 16), 0.01)
	speed = 750

