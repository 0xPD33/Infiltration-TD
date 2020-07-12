extends Area2D

var damage : float = 0
var damage_delay : float = 0.1


func _ready():
	yield(get_tree(), "idle_frame")
	play_explosion_anim()


func set_damage(dmg):
	damage = dmg


func play_explosion_anim():
	$AnimationPlayer.play("explode")
	yield(get_tree().create_timer(damage_delay), "timeout")
	
	var targets = get_overlapping_areas()
	for target in targets:
		target.get_parent().hitpoints -= damage
	
	yield($AnimationPlayer, "animation_finished")
	queue_free()

