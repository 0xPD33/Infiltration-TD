extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	damage = 1.5

	explosion_damage = 5
	explosion_playback_speed = 7.5
	explosion_scale = Vector2(0.5, 0.5)

	speed = 200

