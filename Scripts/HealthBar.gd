extends Node2D

onready var health_bar = $HealthBar


func _ready():
	hide()


func _process(delta):
	global_rotation = 0


func set_max_health(value):
	health_bar.max_value = value


func _on_health_updated(health):
	show()
	health_bar.value = health


func _on_creep_hurt(health):
	_on_health_updated(health)

