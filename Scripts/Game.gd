extends Node2D

var single_turret_tower = load("res://Scenes/Towers/SingleTurretTower.tscn")
var single_turret_towers = []

var light_bomber_tower = load("res://Scenes/Towers/LightBomberTower.tscn")
var light_bomber_towers = []

var sniper_tower = load("res://Scenes/Towers/SniperTower.tscn")
var sniper_towers = []

var double_turret_tower = load("res://Scenes/Towers/DoubleTurretTower.tscn")
var double_turret_towers = []

var instance

var building = false
var wave_started = false

var cash_per_wave : int

onready var pause_menu = get_node("CanvasLayer/PauseMenu")
onready var dev_console = get_node("CanvasLayer/DevConsole")


func _ready():
	add_to_group("Game")
	$MidPosition.global_transform.origin = $LevelCamera.get_camera_screen_center()
	yield(get_tree(), "idle_frame")


func _input(event: InputEvent):
	if Input.is_action_just_pressed ("ui_cancel"):
		show_pause_menu()
	
	# tab key to open the console
	if Input.is_action_just_pressed("dev_console"):
		toggle_dev_console()


func show_pause_menu():
	pause_menu.pause_game()


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


func add_cash_per_wave():
	cash_per_wave = (Global.wave) * 25
	add_cash(cash_per_wave)


func subtract_cash(num):
	Global.cash -= num
	get_tree().call_group("HUD", "sync_cash_label")


func lose_live():
	if Global.lives > 0:
		Global.lives -= 1
		get_tree().call_group("HUD", "sync_lives_label")
	elif Global.lives <= 0:
		print("You lost!")


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
		"DoubleTurretTower":
			subtract_cash(cost)


# BUY BUTTON CODE
# if you click on one of the buy buttons an instance of the tower is instantly added to the game,
# and the tower's code starts running. cash is subtracted only after placing the tower (check function above)


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


func buy_button_4():
	if !building:
		building = true
		$TowerBases.visible = true
		instance = double_turret_tower.instance()
		instance.set_name("DoubleTurretTower" + str(sniper_towers.size()))
		get_node("Towers").add_child(instance)
		double_turret_towers.append(instance)


func start_wave():
	if !wave_started:
		Global.wave += 1
		wave_started = true
		_on_start_wave()


func _on_start_wave():
	get_tree().call_group("HUD", "sync_wave_label")
	get_tree().call_group("Enemy", "setup_stats")
	get_tree().call_group("Spawner", "start_wave")


func end_wave():
	if wave_started:
		if Global.wave > 0:
			add_cash_per_wave()
		
		wave_started = false
		fast_forward(false)
		get_tree().call_group("HUD", "toggle_fast_forward_button")


func reload_game():
	Global.reset()
	get_tree().reload_current_scene()

