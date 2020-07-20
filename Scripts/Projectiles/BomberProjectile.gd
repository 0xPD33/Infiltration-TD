extends Area2D

var explosion = preload("res://Scenes/Effects/Explosion.tscn")

var target = null

var damage : float

var explosion_damage : float
var explosion_playback_speed : float
var explosion_scale = Vector2()

var speed

var velocity


func _ready():
	add_to_group("BomberProjectile")


func _physics_process(delta: float):
	if target:
		velocity = ((target.get_global_transform().origin - position).normalized())
		position += (velocity * speed) * delta
		rotation = velocity.angle()
	else:
		queue_free()


func set_target(new_target):
	target = new_target


func explode(creep_pos):
	var explosion_instance = explosion.instance()
	explosion_instance.position = creep_pos
	explosion_instance.set_damage(explosion_damage)
	explosion_instance.set_speed(explosion_playback_speed)
	explosion_instance.set_scale(explosion_scale) 
	
	get_parent().get_parent().call_deferred("add_child", explosion_instance)
	queue_free()


func _on_BomberProjectile1_area_entered(area: Area2D):
	if area.is_in_group("Enemy"):
		explode(area.get_global_transform().origin)

