extends Path2D

var creep_soldier = load("res://Scenes/Creeps/CreepSoldier.tscn")
var creep_undead_soldier = load("res://Scenes/Creeps/CreepUndeadSoldier.tscn")
var instance

var creeps_spawned : int = 0
var creeps_alive : int = 0
var creeps_max : int
var creep_soldiers_per_wave = [0, 20, 25, 30, 40, 50, 60, 70, 80, 90]
var creep_undead_soldiers_per_wave = [0, 0, 0, 1, 3, 5, 7, 9, 12, 15]
var creep_soldiers_wait_time_per_wave = [0.0, 0.7, 0.65, 0.6, 0.55, 0.5, 0.45, 0.4, 0.35, 0.3]
var creep_undead_soldiers_wait_time_per_wave = [0.0, 0.0, 0.0, 3.0, 2.5, 2.2, 1.9, 1.6, 1.3, 1.0]


# TODO:
# - make undead soldier spawning work correctly. currently in wave 3 5 are being spawned instead of 1:
#	I suppose this happens because of the set_creeps_max() function. I need to figure out another way


func _ready():
	add_to_group("Spawner")


func start_wave():
	$WaveTimer.start()


func _on_WaveTimer_timeout():
	if (Global.wave > 0):
		set_creeps_max()
		$CreepSoldierTimer.start(creep_soldiers_wait_time_per_wave[Global.wave])
		if Global.wave >= 3:
			$CreepUndeadSoldierTimer.start(creep_undead_soldiers_wait_time_per_wave[Global.wave])
		$WaveTimer.stop()


func _on_CreepSoldierTimer_timeout():
	if creeps_spawned < creeps_max:
		creep_soldier_spawn()
	else:
		$CreepSoldierTimer.stop()


func _on_CreepUndeadSoldierTimer_timeout():
	if creeps_spawned < creeps_max:
		creep_undead_soldier_spawn()
	else:
		$CreepUndeadSoldierTimer.stop()


func set_creeps_max():
	creeps_max = creep_soldiers_per_wave[Global.wave] + creep_undead_soldiers_per_wave[Global.wave]


func creep_soldier_spawn():
	instance = creep_soldier.instance()
	add_child(instance)
	creeps_spawned += 1


func creep_undead_soldier_spawn():
	instance = creep_undead_soldier.instance()
	add_child(instance)
	creeps_spawned += 1


func creep_dead():
	creeps_alive = get_tree().get_nodes_in_group("Enemy").size()
	creeps_alive -= 1
	if creeps_alive == 0:
		creeps_spawned = 0
		get_tree().call_group("Game", "end_wave")

