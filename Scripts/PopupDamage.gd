extends Node2D

onready var damage_label = $DamageLabel


func _ready():
	hide()


func popup_damage(damage):
	damage_label.text = "-" + str(damage)
	show()
	$AnimationPlayer.play("damage_anim")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

