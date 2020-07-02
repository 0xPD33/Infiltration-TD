extends Node2D

var fire_rate_value : float = 0
var fire_rate_lvl : int = 0

var fire_range_value : int = 0 
var fire_range_lvl : int = 0

var fire_rate_upgrade_cost : int = 0
var fire_range_upgrade_cost : int = 0

var current_tower

var upgrades = {"tower_upgrades":
	{
	"fire_rate": 
		{
			"levels": [1, 2, 3, 4, 5, 6],
			"rate_of_fire": [0.175, 0.15, 0.125, 0.1, 0.075, 0.05],
			"cost": [10, 25, 50, 80, 125]
		},
	"fire_range":
		{
			"levels": [1, 2, 3, 4, 5, 6],
			"range_of_fire": [275, 300, 325, 350, 400, 500],
			"cost": [25, 75, 125, 200, 300]
		}	
	}
}


func set_current_tower(tower):
	current_tower = tower


func setup_vars():
	fire_rate_value = upgrades["tower_upgrades"]["fire_rate"]["rate_of_fire"][0]
	fire_rate_lvl = upgrades["tower_upgrades"]["fire_rate"]["levels"][0]
	fire_rate_upgrade_cost = upgrades["tower_upgrades"]["fire_rate"]["cost"][fire_rate_lvl]
	fire_range_value = upgrades["tower_upgrades"]["fire_range"]["range_of_fire"][0]
	fire_range_lvl = upgrades["tower_upgrades"]["fire_range"]["levels"][0]
	fire_range_upgrade_cost = upgrades["tower_upgrades"]["fire_range"]["cost"][fire_rate_lvl]


func fire_rate_level_up():
	if current_tower != null:
		if fire_rate_lvl <= upgrades["tower_upgrades"]["fire_rate"]["levels"].size():
			fire_rate_lvl += 1 
			fire_rate_value = fire_rate_lvl
			current_tower.set_stats()
			get_tree().call_group("Game", "add_cash", -fire_rate_upgrade_cost)


func fire_range_level_up():
	if current_tower != null:
		if fire_range_lvl <= upgrades["tower_upgrades"]["fire_range"]["levels"].size():
			fire_range_lvl += 1 
			fire_range_value = fire_range_lvl
			current_tower.set_stats()
			get_tree().call_group("Game", "add_cash", -fire_range_upgrade_cost)

