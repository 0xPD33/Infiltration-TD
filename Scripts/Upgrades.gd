extends Node2D

# need a better solution for this whole script but it works fine for now

var parent_tower_string

var offensive_tower
var defensive_tower

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
var light_bomber_projectile_2 = load("res://Scenes/Projectiles/BomberProjectile2.tscn")

var sniper_projectile_1 = load("res://Scenes/Projectiles/SniperProjectile1.tscn")
var sniper_projectile_2 = load("res://Scenes/Projectiles/SniperProjectile2.tscn")

var double_turret_projectile_1 = load("res://Scenes/Projectiles/DoubleTurretProjectile1.tscn")
var double_turret_projectile_2 = load("res://Scenes/Projectiles/DoubleTurretProjectile2.tscn")

var projectile = null
var projectile_dmg
var projectile_lvl : int = 0
var projectile_upgrade_cost = 0

var upgrades = {"single_turret_tower":
	{
	"fire_rate": 
		{
			"levels": [0, 1, 2, 3, 4, 5, 6, 7],
			"rate_of_fire": [0.3, 0.25, 0.2, 0.135, 0.1, 0.07, 0.05, 0.03],
			"cost": [25, 50, 125, 250, 450, 750, 1100, "---"]
		},
	"fire_range":
		{
			"levels": [0, 1, 2, 3, 4, 5],
			"range_of_fire": [200, 250, 300, 350, 420, 500],
			"cost": [45, 90, 150, 300, 450, "---"]
		},
	"projectiles":
		{
			"levels": [0, 1, 2, 3],
			"projectile": [single_turret_projectile_1, single_turret_projectile_2, single_turret_projectile_3, single_turret_projectile_4],
			"cost": [75, 200, 350, "---"]
		}
	},
	"light_bomber_tower":
	{
	"fire_rate": 
		{
			"levels": [0, 1, 2, 3, 4],
			"rate_of_fire": [2.0, 1.75, 1.5, 1.25, 1.0, 0.7],
			"cost": [40, 80, 160, 320, 750, "---"]
		},
	"fire_range":
		{
			"levels": [0, 1, 2, 3, 4],
			"range_of_fire": [280, 310, 350, 425, 550],
			"cost": [40, 100, 275, 500, "---"]
		},
	"projectiles":
		{
			"levels": [0, 1],
			"projectile": [light_bomber_projectile_1, light_bomber_projectile_2],
			"cost": [150, "---"]
		}
	},
	"sniper_tower":
	{
	"fire_rate":
		{
			"levels": [0, 1, 2, 3, 4, 5],
			"rate_of_fire": [3, 2.7, 2.4, 2.1, 1.6, 1.25],
			"cost": [30, 60, 90, 180, 300, "---"]
		},
		"fire_range":
		{
			"levels": [0, 1, 2, 3, 4],
			"range_of_fire": [600, 650, 700, 775, 900],
			"cost": [40, 80, 200, 400, "---"]
		},
		"projectiles":
		{
			"levels": [0, 1],
			"projectile": [sniper_projectile_1, sniper_projectile_2],
			"cost": [150, "---"]
		}
	},
	"double_turret_tower":
	{
	"fire_rate":
		{
			"levels": [0, 1, 2, 3, 4],
			"rate_of_fire": [0.6, 0.55, 0.5, 0.35, 0.2],
			"cost": [40, 80, 160, 320, "---"]
		},
		"fire_range":
		{
			"levels": [0, 1, 2, 3],
			"range_of_fire": [300, 350, 400, 550],
			"cost": [50, 100, 250, "---"]
		},
		"projectiles":
		{
			"levels": [0, 1],
			"projectile": [double_turret_projectile_1, double_turret_projectile_2],
			"cost": [200, "---"]
		}
	}
}


func _ready():
	setup_vars()


func setup_vars():
	if "SingleTurretTower" in get_parent().name:
		parent_tower_string = "single_turret_tower"
		offensive_tower = true
	elif "LightBomberTower" in get_parent().name:
		parent_tower_string = "light_bomber_tower"
		offensive_tower = true
	elif "SniperTower" in get_parent().name:
		parent_tower_string = "sniper_tower"
		offensive_tower = true
	elif "DoubleTurretTower" in get_parent().name:
		parent_tower_string = "double_turret_tower"
		offensive_tower = true
	else:
		offensive_tower = false
	
	if offensive_tower:
		fire_rate_value = upgrades[parent_tower_string]["fire_rate"]["rate_of_fire"][0]
		fire_rate_lvl = upgrades[parent_tower_string]["fire_rate"]["levels"][0]
		fire_rate_upgrade_cost = upgrades[parent_tower_string]["fire_rate"]["cost"][0]
		fire_range_value = upgrades[parent_tower_string]["fire_range"]["range_of_fire"][0]
		fire_range_lvl = upgrades[parent_tower_string]["fire_range"]["levels"][0]
		fire_range_upgrade_cost = upgrades[parent_tower_string]["fire_range"]["cost"][0]
		projectile = upgrades[parent_tower_string]["projectiles"]["projectile"][0]
		projectile_lvl = upgrades[parent_tower_string]["projectiles"]["levels"][0]
		projectile_upgrade_cost = upgrades[parent_tower_string]["projectiles"]["cost"][0]


func set_fire_rate(tower_string, num):
	fire_rate_value = upgrades[tower_string]["fire_rate"]["rate_of_fire"][num]
	fire_rate_upgrade_cost = upgrades[tower_string]["fire_rate"]["cost"][num]


func set_fire_range(tower_string, num):
	fire_range_value = upgrades[tower_string]["fire_range"]["range_of_fire"][num]
	fire_range_upgrade_cost = upgrades[tower_string]["fire_range"]["cost"][num]


func set_projectile(tower_string, num):
	projectile = upgrades[tower_string]["projectiles"]["projectile"][num]
	projectile_upgrade_cost = upgrades[tower_string]["projectiles"]["cost"][num]


func fire_rate_level_up():
	if typeof(fire_rate_upgrade_cost) == TYPE_INT:
		if Global.cash >= fire_rate_upgrade_cost:
			if "SingleTurretTower" in get_parent().name:
				var max_lvl = upgrades["single_turret_tower"]["fire_rate"]["levels"].size()
				if fire_rate_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
					fire_rate_lvl += 1
					set_fire_rate("single_turret_tower", fire_rate_lvl)
					get_parent().set_stats(true)
			elif "LightBomberTower" in get_parent().name:
				var max_lvl = upgrades["light_bomber_tower"]["fire_rate"]["levels"].size()
				if fire_rate_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
					fire_rate_lvl += 1
					set_fire_rate("light_bomber_tower", fire_rate_lvl)
					get_parent().set_stats(true)
			elif "SniperTower" in get_parent().name:
				var max_lvl = upgrades["sniper_tower"]["fire_rate"]["levels"].size()
				if fire_rate_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
					fire_rate_lvl += 1
					set_fire_rate("sniper_tower", fire_rate_lvl)
					get_parent().set_stats(true)
			elif "DoubleTurretTower" in get_parent().name:
				var max_lvl = upgrades["double_turret_tower"]["fire_rate"]["levels"].size()
				if fire_rate_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_rate_upgrade_cost)
					fire_rate_lvl += 1
					set_fire_rate("double_turret_tower", fire_rate_lvl)
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
					set_fire_range("single_turret_tower", fire_range_lvl)
					get_parent().set_stats(true)
			elif "LightBomberTower" in get_parent().name:
				var max_lvl = upgrades["light_bomber_tower"]["fire_range"]["levels"].size()
				if fire_range_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
					fire_range_lvl += 1
					set_fire_range("light_bomber_tower", fire_range_lvl)
					get_parent().set_stats(true)
			elif "SniperTower" in get_parent().name:
				var max_lvl = upgrades["sniper_tower"]["fire_range"]["levels"].size()
				if fire_range_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
					fire_range_lvl += 1
					set_fire_range("sniper_tower", fire_range_lvl)
					get_parent().set_stats(true)
			elif "DoubleTurretTower" in get_parent().name:
				var max_lvl = upgrades["double_turret_tower"]["fire_range"]["levels"].size()
				if fire_range_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", fire_range_upgrade_cost)
					fire_range_lvl += 1
					set_fire_range("double_turret_tower", fire_range_lvl)
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
					set_projectile("single_turret_tower", projectile_lvl)
					get_parent().set_stats(true)
			elif "LightBomberTower" in get_parent().name:
				var max_lvl = upgrades["light_bomber_tower"]["projectiles"]["levels"].size()
				if projectile_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", projectile_upgrade_cost)
					projectile_lvl += 1
					set_projectile("light_bomber_tower", projectile_lvl)
					get_parent().set_stats(true)
			elif "SniperTower" in get_parent().name:
				var max_lvl = upgrades["sniper_tower"]["projectiles"]["levels"].size()
				if projectile_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", projectile_upgrade_cost)
					projectile_lvl += 1
					set_projectile("sniper_tower", projectile_lvl)
					get_parent().set_stats(true)
			elif "DoubleTurretTower" in get_parent().name:
				var max_lvl = upgrades["double_turret_tower"]["projectiles"]["levels"].size()
				if projectile_lvl < max_lvl:
					get_tree().call_group("Game", "subtract_cash", projectile_upgrade_cost)
					projectile_lvl += 1
					set_projectile("double_turret_tower", projectile_lvl)
					get_parent().set_stats(true)
	else:
		return

