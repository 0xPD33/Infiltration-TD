extends Node2D

var fire_rate_value : float = 0
var fire_rate_lvl : int = 0
var fire_rate_upgrade_cost = 0

var fire_range_value : int = 0 
var fire_range_lvl : int = 0
var fire_range_upgrade_cost = 0

var projectile1 = load("res://Scenes/Projectiles/Projectile1.tscn")

var projectile = null
var projectile_level : int = 0
var projectile_upgrade_cost = 0

var upgrades = {"tower_upgrades":
	{
	"fire_rate": 
		{
			"levels": [0, 1, 2, 3, 4, 5],
			"rate_of_fire": [0.15, 0.125, 0.1, 0.07, 0.025, 0.01],
			"cost": [10, 20, 50, 150, 300, "---"]
		},
	"fire_range":
		{
			"levels": [0, 1, 2, 3, 4, 5],
			"range_of_fire": [275, 300, 325, 350, 400, 500],
			"cost": [25, 75, 125, 200, 300, "---"]
		},
	"projectiles":
		{
			"levels": [0, 1, 2, 3, 4, 5],
			"projectile": [projectile1, projectile1, projectile1, projectile1, projectile1, projectile1],
			"cost": [25, 75, 125, 200, 300, "---"]
		}
	}
}


func _ready():
	setup_vars()
	add_to_group("Upgrades")


func setup_vars():
	fire_rate_value = upgrades["tower_upgrades"]["fire_rate"]["rate_of_fire"][0]
	fire_rate_lvl = upgrades["tower_upgrades"]["fire_rate"]["levels"][0]
	fire_rate_upgrade_cost = upgrades["tower_upgrades"]["fire_rate"]["cost"][0]
	fire_range_value = upgrades["tower_upgrades"]["fire_range"]["range_of_fire"][0]
	fire_range_lvl = upgrades["tower_upgrades"]["fire_range"]["levels"][0]
	fire_range_upgrade_cost = upgrades["tower_upgrades"]["fire_range"]["cost"][0]
	projectile = upgrades["tower_upgrades"]["projectiles"]["projectile"][0]
	projectile_level = upgrades["tower_upgrades"]["projectiles"]["levels"][0]
	projectile_upgrade_cost = upgrades["tower_upgrades"]["projectiles"]["cost"][0]


func set_fire_rate(num):
	fire_rate_value = upgrades["tower_upgrades"]["fire_rate"]["rate_of_fire"][num]
	fire_rate_upgrade_cost = upgrades["tower_upgrades"]["fire_rate"]["cost"][num]


func fire_rate_level_up():
	if typeof(fire_rate_upgrade_cost) == TYPE_INT:
		if Global.cash >= fire_rate_upgrade_cost:
			if fire_rate_lvl < upgrades["tower_upgrades"]["fire_rate"]["levels"].size():
				get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
				fire_rate_lvl += 1
				set_fire_rate(fire_rate_lvl)
				get_parent().set_stats()
	else:
		return


func fire_range_level_up():
	if Global.cash >= fire_range_upgrade_cost:
		if fire_range_lvl < upgrades["tower_upgrades"]["fire_range"]["levels"].size():
			get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
			fire_range_lvl += 1

