extends "res://Scripts/Projectiles/BomberProjectile.gd"


func _ready():
	damage = 3

	explosion_damage = 18
	explosion_playback_speed = 9.0
	explosion_scale = Vector2(0.8, 0.8)

	speed = 300

