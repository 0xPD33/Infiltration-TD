extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	randomize()
	damage = 1

	explosion_damage = stepify(rand_range(7.5, 8.5), 0.01)
	explosion_playback_speed = 9
	explosion_scale = Vector2(0.5, 0.5)

	speed = 200

