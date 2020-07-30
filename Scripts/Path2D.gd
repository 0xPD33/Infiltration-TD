extends Path2D

var creep_soldier = load("res://Scenes/Creeps/CreepSoldier.tscn")
var creep_undead_soldier = load("res://Scenes/Creeps/CreepUndeadSoldier.tscn")
var creep_green_tank = load("res://Scenes/Creeps/CreepGreenTank.tscn")

var instance

var creeps_alive : int = 0

# need a better solution for this:

var creep_soldiers_spawned = 0
var creep_soldiers_per_wave = [0, 15, 20, 25, 30, 35, 40, 50, 60, 70, 80, 90, 100, 105, 110, 115]
var creep_soldiers_wait_time_per_wave = [0.0, 0.8, 0.75, 0.7, 0.65, 0.6, 0.55, 0.5, 0.49, 0.48, 0.47, 0.46, 0.45, 0.44, 0.43, 0.42]

var creep_undead_soldiers_spawned = 0
var creep_undead_soldiers_per_wave = [0, 0, 0, 1, 3, 5, 7, 9, 10, 11, 12, 14, 16, 18, 20, 20]
var creep_undead_soldiers_wait_time_per_wave = [0.0, 0.0, 0.0, 3.0, 2.5, 2.2, 1.9, 1.6, 1.3, 1.0, 0.99, 0.98, 0.97, 0.96, 0.95, 0.94]

var creep_green_tanks_spawned = 0
var creep_green_tanks_per_wave = [0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 7, 8, 9, 10, 10]
var creep_green_tanks_wait_time_per_wave = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 3.5, 3.0, 2.5, 2.0, 1.99, 1.98, 1.97, 1.96, 1.95]


func _ready():
	add_to_group("Spawner")


func start_wave():
	$WaveTimer.start()


func _on_WaveTimer_timeout():
	if (Global.wave > 0):
		$CreepSoldierTimer.start(creep_soldiers_wait_time_per_wave[Global.wave])
		
		if Global.wave >= 3:
			$CreepUndeadSoldierTimer.start(creep_undead_soldiers_wait_time_per_wave[Global.wave])
		
		if Global.wave >= 6:
			$CreepGreenTankTimer.start(creep_green_tanks_wait_time_per_wave[Global.wave])
		
		$WaveTimer.stop()


func _on_CreepSoldierTimer_timeout():
	if creep_soldiers_spawned < creep_soldiers_per_wave[Global.wave]:
		creep_soldier_spawn()
	else:
		$CreepSoldierTimer.stop()


func _on_CreepUndeadSoldierTimer_timeout():
	if creep_undead_soldiers_spawned < creep_undead_soldiers_per_wave[Global.wave]:
		creep_undead_soldier_spawn()
	else:
		$CreepUndeadSoldierTimer.stop()


func _on_CreepGreenTankTimer_timeout():
	if creep_green_tanks_spawned < creep_green_tanks_per_wave[Global.wave]:
		creep_green_tank_spawn()
	else:
		$CreepGreenTankTimer.stop()


func creep_soldier_spawn():
	instance = creep_soldier.instance()
	add_child(instance)
	creep_soldiers_spawned += 1


func creep_undead_soldier_spawn():
	instance = creep_undead_soldier.instance()
	add_child(instance)
	creep_undead_soldiers_spawned += 1


func creep_green_tank_spawn():
	instance = creep_green_tank.instance()
	add_child(instance)
	creep_green_tanks_spawned += 1


func creep_dead():
	creeps_alive = get_tree().get_nodes_in_group("Enemy").size()
	
	# creeps_alive sometimes gets stuck on 1 and prevents wave from ending
	creeps_alive -= 1
	
#	if creeps_alive == 0:
#		creep_soldiers_spawned = 0
#		creep_undead_soldiers_spawned = 0
#		creep_green_tanks_spawned = 0
#		get_tree().call_group("Game", "end_wave")
	if creeps_alive <= 1:
		yield(get_tree().create_timer(2.0), "timeout")
		creep_soldiers_spawned = 0
		creep_undead_soldiers_spawned = 0
		creep_green_tanks_spawned = 0
		get_tree().call_group("Game", "end_wave")

