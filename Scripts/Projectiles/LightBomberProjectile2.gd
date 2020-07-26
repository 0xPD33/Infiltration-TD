extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	damage = 2

	explosion_damage = 12
	explosion_playback_speed = 8.5
	explosion_scale = Vector2(0.7, 0.7)

	speed = 250

