extends Node2D

# need a better solution for this whole script but it works fine for now

var fire_rate_value : float = 0
var fire_rate_lvl : int = 0
var fire_rate_upgrade_cost = 0

var fire_range_value : int = 0 
var fire_range_lvl : int = 0
var fire_range_upgrade_cost = 0

var single_turret_projectile_1 = load("res://Scenes/Projectiles/SingleTurretProjectile1.tscn")
var single_turret_projectile_2 = load("res://Scenes/Projectiles/SingleTurretProjectile2.tscn")
var single_turret_projectile_3 = load("res://Scenes/Projectiles/SingleTurretProjectile3.tscn")
var single_turret_projectile_4 = load("res://Scenes/Projectiles/SingleTurretProjectile4.tscn")

var light_bomber_projectile_1 = load("res://Scenes/Projectiles/BomberProjectile1.tscn")

var projectile = null
var projectile_lvl : int = 0
var projectile_upgrade_cost = 0

var upgrades = {"single_turret_tower":
	{
	"fire_rate": 
		{
			"levels": [0, 1, 2, 3, 4, 5, 6],
			"rate_of_fire": [0.3, 0.25, 0.2, 0.135, 0.1, 0.07, 0.05],
			"cost": [25, 50, 135, 225, 350, 450, "---"]
		},
	"fire_range":
		{
			"levels": [0, 1, 2, 3, 4, 5],
			"range_of_fire": [200, 225, 250, 300, 330, 375],
			"cost": [45, 90, 150, 225, 350, "---"]
		},
	"projectiles":
		{
			"levels": [0, 1, 2, 3],
			"projectile": [single_turret_projectile_1, single_turret_projectile_2, single_turret_projectile_3, single_turret_projectile_4],
			"cost": [75, 200, 350, "---", "---", "---"]
		}
	},
	"light_bomber_tower":
	{
	"fire_rate": 
		{
			"levels": [0, 1, 2, 3, 4],
			"rate_of_fire": [1.8, 1.5, 1.2, 0.9, 0.6],
			"cost": [30, 60, 120, 240, "---"]
		},
	"fire_range":
		{
			"levels": [0, 1, 2, 3, 4],
			"range_of_fire": [275, 300, 350, 425, 550],
			"cost": [50, 120, 240, 450, "---"]
		},
	"projectiles":
		{
			"levels": [0],
			"projectile": [light_bomber_projectile_1],
			"cost": ["---"]
		}
	}
}


func _ready():
	setup_vars()


func setup_vars():
	if "SingleTurretTower" in get_parent().name:
		fire_rate_value = upgrades["single_turret_tower"]["fire_rate"]["rate_of_fire"][0]
		fire_rate_lvl = upgrades["single_turret_tower"]["fire_rate"]["levels"][0]
		fire_rate_upgrade_cost = upgrades["single_turret_tower"]["fire_rate"]["cost"][0]
		fire_range_value = upgrades["single_turret_tower"]["fire_range"]["range_of_fire"][0]
		fire_range_lvl = upgrades["single_turret_tower"]["fire_range"]["levels"][0]
		fire_range_upgrade_cost = upgrades["single_turret_tower"]["fire_range"]["cost"][0]
		projectile = upgrades["single_turret_tower"]["projectiles"]["projectile"][0]
		projectile_lvl = upgrades["single_turret_tower"]["projectiles"]["levels"][0]
		projectile_upgrade_cost = upgrades["single_turret_tower"]["projectiles"]["cost"][0]
	
	elif "LightBomberTower" in get_parent().name:
		fire_rate_value = upgrades["light_bomber_tower"]["fire_rate"]["rate_of_fire"][0]
		fire_rate_lvl = upgrades["light_bomber_tower"]["fire_rate"]["levels"][0]
		fire_rate_upgrade_cost = upgrades["light_bomber_tower"]["fire_rate"]["cost"][0]
		fire_range_value = upgrades["light_bomber_tower"]["fire_range"]["range_of_fire"][0]
		fire_range_lvl = upgrades["light_bomber_tower"]["fire_range"]["levels"][0]
		fire_range_upgrade_cost = upgrades["light_bomber_tower"]["fire_range"]["cost"][0]
		projectile = upgrades["light_bomber_tower"]["projectiles"]["projectile"][0]
		projectile_lvl = upgrades["light_bomber_tower"]["projectiles"]["levels"][0]
		projectile_upgrade_cost = upgrades["light_bomber_tower"]["projectiles"]["cost"][0]


func set_fire_rate(num):
	if "SingleTurretTower" in get_parent().name:
		fire_rate_value = upgrades["single_turret_tower"]["fire_rate"]["rate_of_fire"][num]
		fire_rate_upgrade_cost = upgrades["single_turret_tower"]["fire_rate"]["cost"][num]
	elif "LightBomberTower" in get_parent().name:
		fire_rate_value = upgrades["light_bomber_tower"]["fire_rate"]["rate_of_fire"][num]
		fire_rate_upgrade_cost = upgrades["light_bomber_tower"]["fire_rate"]["cost"][num]


func set_fire_range(num):
	if "SingleTurretTower" in get_parent().name:
		fire_range_value = upgrades["single_turret_tower"]["fire_range"]["range_of_fire"][num]
		fire_range_upgrade_cost = upgrades["single_turret_tower"]["fire_range"]["cost"][num]
	elif "LightBomberTower" in get_parent().name:
		fire_range_value = upgrades["light_bomber_tower"]["fire_range"]["range_of_fire"][num]
		fire_range_upgrade_cost = upgrades["light_bomber_tower"]["fire_range"]["cost"][num]


func set_projectile(num):
	if "SingleTurretTower" in get_parent().name:
		projectile = upgrades["single_turret_tower"]["projectiles"]["projectile"][num]
		projectile_upgrade_cost = upgrades["single_turret_tower"]["projectiles"]["cost"][num]
	elif "LightBomberTower" in get_parent().name:
		projectile = upgrades["light_bomber_tower"]["projectiles"]["projectile"][num]
		projectile_upgrade_cost = upgrades["light_bomber_tower"]["projectiles"]["cost"][num]


func fire_rate_level_up():
	if typeof(fire_rate_upgrade_cost) == TYPE_INT:
		if Global.cash >= fire_rate_upgrade_cost:
			if "SingleTurretTower" in get_parent().name:
				var max_lvl = upgrades["single_turret_tower"]["fire_rate"]["levels"].size()
				if fire_rate_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
					fire_rate_lvl += 1
					set_fire_rate(fire_rate_lvl)
					get_parent().set_stats(true)
	else:
		return


func fire_range_level_up():
	if typeof(fire_range_upgrade_cost) == TYPE_INT:
		if Global.cash >= fire_range_upgrade_cost:
			if "SingleTurretTower" in get_parent().name:
				var max_lvl = upgrades["single_turret_tower"]["fire_range"]["levels"].size()
				if fire_range_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
					fire_range_lvl += 1
					set_fire_range(fire_range_lvl)
					get_parent().set_stats(true)
			elif "LightBomberTower" in get_parent().name:
				var max_lvl = upgrades["light_bomber_tower"]["fire_range"]["levels"].size()
				if fire_range_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
					fire_range_lvl += 1
					set_fire_range(fire_range_lvl)
					get_parent().set_stats(true)
	else:
		return


func projectile_level_up():
	if typeof(projectile_upgrade_cost) == TYPE_INT:
		if Global.cash >= projectile_upgrade_cost:
			if "SingleTurretTower" in get_parent().name:
				var max_lvl = upgrades["single_turret_tower"]["projectiles"]["levels"].size()
				if projectile_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", projectile_upgrade_cost)
					projectile_lvl += 1
					set_projectile(projectile_lvl)
					get_parent().set_stats(true)
	else:
		return

