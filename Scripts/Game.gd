extends Node2D

var single_turret_tower = load("res://Scenes/Towers/SingleTurretTower.tscn")
var single_turret_towers = []

var light_bomber_tower = load("res://Scenes/Towers/LightBomberTower.tscn")
var light_bomber_towers = []

var sniper_tower = load("res://Scenes/Towers/SniperTower.tscn")
var sniper_towers = []

var instance

var building = false
var wave_started = false

var cash_per_wave = [0, 10, 25, 50, 100, 125, 150, 175, 200, 250]

onready var dev_console = get_node("CanvasLayer/DevConsole")


func _ready():
	add_to_group("Game")
	yield(get_tree(), "idle_frame")


func _input(event: InputEvent):
	if Input.is_action_just_pressed ("ui_cancel"):
		end_game()
	if Input.is_action_just_pressed("dev_console"):
		toggle_dev_console()


func toggle_dev_console():
	if !dev_console.opened:
		dev_console.open()
	elif dev_console.opened:
		dev_console.close()


func fast_forward(value):
	if value:
		Engine.time_scale = 2.0
	else:
		Engine.time_scale = 1.0


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


func tower_built(tower, cost):
	building = false
	$TowerBases.visible = false
	
	match tower:
		"SingleTurretTower":
			subtract_cash(cost)
		"LightBomberTower":
			subtract_cash(cost)
		"SniperTower":
			subtract_cash(cost)


func buy_button_1():
	if !building:
		building = true
		$TowerBases.visible = true
		instance = single_turret_tower.instance()
		instance.set_name("SingleTurretTower" + str(single_turret_towers.size()))
		get_node("Towers").add_child(instance)
		single_turret_towers.append(instance)


func buy_button_2():
	if !building:
		building = true
		$TowerBases.visible = true
		instance = light_bomber_tower.instance()
		instance.set_name("LightBomberTower" + str(single_turret_towers.size()))
		get_node("Towers").add_child(instance)
		light_bomber_towers.append(instance)


func buy_button_3():
	if !building:
		building = true
		$TowerBases.visible = true
		instance = sniper_tower.instance()
		instance.set_name("SniperTower" + str(sniper_towers.size()))
		get_node("Towers").add_child(instance)
		sniper_towers.append(instance)


func start_wave():
	if !wave_started:
		Global.wave += 1
		wave_started = true
		on_new_wave()
		get_tree().call_group("Spawner", "start_wave")


func on_new_wave():
	get_tree().call_group("HUD", "sync_wave_label")
	get_tree().call_group("Enemy", "setup_stats")


func end_wave():
	add_cash(cash_per_wave[Global.wave])
	wave_started = false
	fast_forward(false)
	get_tree().call_group("HUD", "toggle_fast_forward_button")


func end_game():
	get_tree().quit()

