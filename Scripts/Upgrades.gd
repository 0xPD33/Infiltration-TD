extends Node2D

var fire_rate_value : float = 0
var fire_rate_lvl : int = 0
var fire_rate_upgrade_cost : int = 0

var fire_range_value : int = 0 
var fire_range_lvl : int = 0
var fire_range_upgrade_cost : int = 0

var current_lvl = 0

var upgrades = {"tower_upgrades":
	{
	"fire_rate": 
		{
			"levels": [1, 2, 3, 4, 5, 6],
			"rate_of_fire": [0.005, 0.15, 0.125, 0.1, 0.075, 0.05],
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


func _ready():
	setup_vars(current_lvl)
	add_to_group("Upgrades")


func get_var(value):
	match value:
		"fire_rate_value":
			return fire_rate_value
		"fire_rate_lvl":
			return fire_rate_lvl
		"fire_rate_upgrade_cost":
			return fire_rate_upgrade_cost
		"fire_range_value":
			return fire_range_value
		"fire_range_lvl":
			return fire_range_lvl
		"fire_range_upgrade_cost":
			return fire_range_upgrade_cost


func setup_vars(num):
	fire_rate_value = upgrades["tower_upgrades"]["fire_rate"]["rate_of_fire"][num]
	fire_rate_lvl = upgrades["tower_upgrades"]["fire_rate"]["levels"][num]
	fire_rate_upgrade_cost = upgrades["tower_upgrades"]["fire_rate"]["cost"][num]
	fire_range_value = upgrades["tower_upgrades"]["fire_range"]["range_of_fire"][num]
	fire_range_lvl = upgrades["tower_upgrades"]["fire_range"]["levels"][num]
	fire_range_upgrade_cost = upgrades["tower_upgrades"]["fire_range"]["cost"][num]


func fire_rate_level_up():
	if Global.cash >= fire_rate_upgrade_cost:
		if fire_rate_lvl <= upgrades["tower_upgrades"]["fire_rate"]["levels"].size():
			get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
			current_lvl += 1
			setup_vars(current_lvl)
			get_parent().set_stats()


func fire_range_level_up():
	if Global.cash >= fire_range_upgrade_cost:
		if fire_range_lvl <= upgrades["tower_upgrades"]["fire_range"]["levels"].size():
			get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
			current_lvl += 1
			setup_vars(current_lvl)

