extends Area2D

var explosion = preload("res://Scenes/Effects/Explosion.tscn")
var explosion_instance

var exploded = false

var target = null

var damage : float = 10.0
var splash_damage : float = 7.5

var speed = 150

var velocity


func _ready():
	add_to_group("BomberProjectile")


func _physics_process(delta: float):
	if target:
		velocity = ((target.get_global_transform().origin - position).normalized())
		position += (velocity * speed) * delta
		rotation = velocity.angle()
	else:
		if exploded:
			queue_free()


func set_target(new_target):
	target = new_target


func explode(creep_pos):
	explosion_instance = explosion.instance()
	explosion_instance.position = creep_pos
	explosion_instance.set_damage(splash_damage)
	explosion_instance.set_projectile(self)
	
	# still getting area_set_shape_disabled error.
	# I think this happens because the projectile gets freed from the game too fast.
	# I need to add the explosion as a child to the bomber projectile,
	# hide the main projectile on collision with an enemy,
	# then let the explosion play and hopefully the explosion collision works then.
	get_parent().add_child(explosion_instance)


func explosion_done():
	exploded = true


func _on_BomberProjectile1_area_entered(area: Area2D):
	if area.is_in_group("Enemy"):
		explode(area.get_global_transform().origin)

