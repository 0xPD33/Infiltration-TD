extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween


func _ready():
	_on_max_health_updated(get_parent().hitpoints)


func _on_health_updated(health):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()


func _on_max_health_updated(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health


func _on_CreepSoldier_hurt(damage):
	_on_health_updated(damage)

