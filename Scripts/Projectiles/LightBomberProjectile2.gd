extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	randomize()
	damage = 2

	explosion_damage = stepify(rand_range(11.5, 13), 0.01)
	explosion_playback_speed = 8.5
	explosion_scale = Vector2(0.7, 0.7)

	speed = 250

