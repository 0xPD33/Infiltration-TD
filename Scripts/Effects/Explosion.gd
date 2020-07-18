extends Area2D

var damage : float = 0


func _ready():
	add_to_group("Explosion")
	explode()


func set_speed(spd):
	$AnimationPlayer.playback_speed = spd


func set_damage(dmg):
	damage = dmg


func explode():
	$AnimationPlayer.play("explode")
	get_tree().call_group("LevelCamera", "screen_shake")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()

