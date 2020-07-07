extends PopupMenu

var upgrades

onready var fire_rate_desc = $MarginContainer/StatsContainer/FireRateContainer/FireRateDesc
onready var fire_rate_cost_label = $MarginContainer/StatsContainer/FireRateContainer/FireRateCostLabel

onready var fire_range_desc = $MarginContainer/StatsContainer/FireRangeContainer/FireRangeDesc
onready var fire_range_cost_label = $MarginContainer/StatsContainer/FireRangeContainer/FireRangeCostLabel

onready var projectile_desc = $MarginContainer/StatsContainer/ProjectileContainer/ProjectileDesc
onready var projectile_cost_label = $MarginContainer/StatsContainer/ProjectileContainer/ProjectileCostLabel

signal closed


func _ready():
	upgrades = get_parent().get_node("Upgrades")
	sync_fire_rate_desc(upgrades.fire_rate_lvl + 1)
	sync_fire_rate_cost(upgrades.fire_rate_upgrade_cost)
	sync_fire_range_desc(upgrades.fire_range_lvl + 1)
	sync_fire_range_cost(upgrades.fire_range_upgrade_cost)
	sync_projectile_desc(upgrades.projectile_lvl + 1)
	sync_projectile_cost(upgrades.projectile_upgrade_cost)
	connect("closed", get_parent(), "_on_TowerMenu_closed")


func _on_FireRateBtn_pressed():
	upgrades.fire_rate_level_up()
	sync_fire_rate_desc(upgrades.fire_rate_lvl + 1)
	sync_fire_rate_cost(upgrades.fire_rate_upgrade_cost)


func _on_FireRangeBtn_pressed():
	upgrades.fire_range_level_up()
	sync_fire_range_desc(upgrades.fire_range_lvl + 1)
	sync_fire_range_cost(upgrades.fire_range_upgrade_cost)


func _on_ProjectileBtn_pressed():
	upgrades.projectile_level_up()
	sync_projectile_desc(upgrades.projectile_lvl + 1)
	sync_projectile_cost(upgrades.projectile_upgrade_cost)


func sync_fire_rate_desc(fire_rate_lvl):
	fire_rate_desc.text = "Fire Rate (Lvl." + str(fire_rate_lvl) + ")" 


func sync_fire_rate_cost(fire_rate_cost):
	fire_rate_cost_label.text = "Cost: " + str(fire_rate_cost)


func sync_fire_range_desc(fire_range_lvl):
	fire_range_desc.text = "Fire Range (Lvl." + str(fire_range_lvl) + ")" 


func sync_fire_range_cost(fire_range_cost):
	fire_range_cost_label.text = "Cost: " + str(fire_range_cost)


func sync_projectile_desc(projectile_lvl):
	projectile_desc.text = "Projectile (Lvl." + str(projectile_lvl) + ")" 


func sync_projectile_cost(projectile_cost):
	projectile_cost_label.text = "Cost: " + str(projectile_cost) 


func _on_CloseButton_pressed():
	hide()
	emit_signal("closed")

