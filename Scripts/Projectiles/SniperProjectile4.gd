extends "res://Scripts/Projectiles/SniperProjectile.gd"


func _ready():
	randomize()
	damage = stepify(rand_range(32, 37), 0.01)
	speed = 1000

