extends Area2D

var explosion = load("res://Scenes/Effects/Explosion.tscn")
var explosion_instance

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
		queue_free()


func set_target(new_target):
	target = new_target


func explode():
	pass

