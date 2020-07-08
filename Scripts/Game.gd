extends Node2D

var single_turret_tower = load("res://Scenes/Towers/TurretTower1.tscn")
var single_turret_towers = []
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


func subtract_cash(num):
	Global.cash -= num
	get_tree().call_group("HUD", "sync_cash_label")


func lose_live():
	if Global.lives > 0:
		Global.lives -= 1
		get_tree().call_group("HUD", "sync_lives_label")
	elif Global.lives <= 0:
		end_game()


func tower_built(tower):
	building = false
	$TowerBases.visible = false
	
	match tower:
		"SingleTurretTower":
			subtract_cash(50)


func buy_button_1():
	if !building:
		building = true
		$TowerBases.visible = true
		instance = single_turret_tower.instance()
		instance.set_name("SingleTurretTower" + str(single_turret_towers.size()))
		get_node("Towers").add_child(instance)
		single_turret_towers.append(instance)


func fast_forward(value):
	if value:
		Engine.time_scale = 2.0
	else:
		Engine.time_scale = 1.0


func start_wave():
	if !wave_started:
		Global.wave += 1
		on_new_wave()
		wave_started = true
		get_tree().call_group("Spawner", "start_wave")


func on_new_wave():
	get_tree().call_group("HUD", "sync_wave_label")
	get_tree().call_group("Enemy", "setup_stats")


func end_wave():
	if wave_started:
		wave_started = false
		fast_forward(false)
		get_tree().call_group("HUD", "toggle_fast_forward_button")


func end_game():
	get_tree().quit()

