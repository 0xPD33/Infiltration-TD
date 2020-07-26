extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	damage = 1

	explosion_damage = 8
	explosion_playback_speed = 9
	explosion_scale = Vector2(0.5, 0.5)

	speed = 200

