extends Path2D

var soldier_creep = load("res://Scenes/SoldierCreep.tscn")
var instance

var creeps_spawned : int = 0
var creeps_alive : int = 0
var creeps_max : int
var creeps_per_wave = [15, 20, 25, 30, 40, 50, 60]
var creeps_wait_time_per_wave = [0.6, 0.55, 0.5, 0.45, 0.4, 0.35, 0.3]


func _ready():
	add_to_group("Spawner")
	creep_spawn_time()


func start_wave():
	$WaveTimer.start()


func _on_WaveTimer_timeout():
	if Global.wave < creeps_per_wave.size():
		creeps_max = creeps_per_wave[Global.wave]
		creep_spawn_time()
		$CreepTimer.start()
		$WaveTimer.stop()


func _on_CreepTimer_timeout():
	if creeps_spawned < creeps_max:
		creep_spawn()
	else:
		$CreepTimer.stop()


func creep_spawn_time():
	$CreepTimer.wait_time = creeps_wait_time_per_wave[Global.wave]


func creep_spawn():
	instance = soldier_creep.instance()
	add_child(instance)
	creeps_spawned += 1
	creeps_alive = get_tree().get_nodes_in_group("Enemy").size()


func creep_dead():
	creeps_alive -= 1
	if creeps_alive == 0:
		creeps_spawned = 0
		if Global.wave < creeps_per_wave.size():
			get_tree().call_group("Game", "advance_wave")
		else:
			get_tree().call_group("Game", "end_wave")

