extends Node2D

var turret_tower_1 = load("res://Scenes/Towers/TurretTower1.tscn")
var instance

var building = false
var wave_started = false


func _ready():
	add_to_group("Game")
	yield(get_tree(), "idle_frame")


func _input(event: InputEvent):
	if Input.is_action_just_pressed ("ui_cancel"):
		end_game()


func add_cash(num):
	Global.cash += num
	get_tree().call_group("HUD", "sync_cash_label")


func lose_live():
	if Global.lives > 0:
		Global.lives -= 1
		get_tree().call_group("HUD", "sync_lives_label")
	elif Global.lives <= 0:
		end_game()


func tower_built(tower_name):
	building = false
	
	match tower_name:
		"TurretTower1":
			Global.cash -= 50
	
	get_tree().call_group("HUD", "sync_cash_label")


func buy_button_1():
	if !building and Global.cash >= 50:
		building = true
		instance = turret_tower_1.instance()
		add_child(instance)


func start_wave():
	wave_started = true
	get_tree().call_group("Spawner", "start_wave")


func advance_wave():
	if wave_started:
		end_wave()
		Global.wave += 1
		get_tree().call_group("HUD", "sync_wave_label")
		get_tree().call_group("HUD", "panel_fade_in")


func end_wave():
	wave_started = false


func end_game():
	get_tree().quit()

