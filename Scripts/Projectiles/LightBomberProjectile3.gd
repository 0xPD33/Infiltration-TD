extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	damage = 3

	explosion_damage = stepify(rand_range(17, 20.5), 0.01)
	explosion_playback_speed = 9.0
	explosion_scale = Vector2(0.8, 0.8)

	speed = 300

