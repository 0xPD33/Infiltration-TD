extends Area2D

var target = null

var damage : float = 8.0
var speed = 100

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


func _on_BomberProjectile1_area_entered(area):
	if area.is_in_group("Enemy"):
		pass

