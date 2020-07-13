extends Area2D

var damage : float = 0
var damage_delay : float = 0.05

var projectile_instance = null

signal exploded


func _ready():
	yield(get_tree(), "idle_frame")
	explode()


func set_damage(dmg):
	damage = dmg


func set_projectile(projectile):
	projectile_instance = projectile
	connect("exploded", projectile_instance, "explosion_done")


func explode():
	$AnimationPlayer.play("explode")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("exploded")
	queue_free()


func _on_Explosion_area_entered(area: Area2D):
	yield(get_tree().create_timer(damage_delay), "timeout")
	
	if area.is_in_group("Enemy"):
		area.get_parent().receive_damage(damage)

