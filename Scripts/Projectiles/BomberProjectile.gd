extends Area2D

var target = null
var exploding = false

var damage : float = 10.0
var splash_damage : float = 2.0
var speed = 150

var velocity


func _ready():
	add_to_group("Projectile")


func _physics_process(delta: float):
	if target:
		velocity = ((target.get_global_transform().origin - position).normalized())
		position += (velocity * speed) * delta
		rotation = velocity.angle()
	else:
		queue_free()


func set_target(new_target):
	target = new_target


func _on_BomberSplashDamage_area_entered(area):
	if area.is_in_group("Enemy"):
		area.get_parent().receive_splash_damage(splash_damage)


#func explode():
#	$Explosion.global_position = get_global_position()
#	$Explosion/MainExplosion.emitting = true
#	$Explosion/MainExplosion/Shards.emitting = true
#	$Explosion/MainExplosion/Smoke.emitting = true
#	$Explosion/MainExplosion/Smoke2.emitting = true
#	exploding = is_exploding()
#	if !exploding:
#		pass


#func is_exploding():
#	if $Explosion/MainExplosion.emitting:
#		exploding = true
#		return exploding

