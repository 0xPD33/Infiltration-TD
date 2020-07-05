extends Area2D

var target = null

var damage = 1
var speed = 300

var velocity


func _ready():
	add_to_group("Projectile")


func _physics_process(delta: float):
	if target:
		velocity = ((target.get_global_transform().origin - position).normalized()
					* speed)
		position += velocity * delta
		rotation = velocity.angle()
	else:
		queue_free()


func set_target(new_target):
	target = new_target

