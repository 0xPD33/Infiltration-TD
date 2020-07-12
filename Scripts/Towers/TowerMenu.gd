extends PopupMenu

var upgrades

onready var fire_rate_desc = $MarginContainer/MainContainer/StatsContainer/FireRateContainer/FireRateDesc
onready var fire_rate_cost_label = $MarginContainer/MainContainer/StatsContainer/FireRateContainer/FireRateCostLabel

onready var fire_range_desc = $MarginContainer/MainContainer/StatsContainer/FireRangeContainer/FireRangeDesc
onready var fire_range_cost_label = $MarginContainer/MainContainer/StatsContainer/FireRangeContainer/FireRangeCostLabel

onready var projectile_desc = $MarginContainer/MainContainer/StatsContainer/ProjectileContainer/ProjectileDesc
onready var projectile_cost_label = $MarginContainer/MainContainer/StatsContainer/ProjectileContainer/ProjectileCostLabel

onready var fire_mode_1_button = $MarginContainer/MainContainer/SettingsContainer/FireModeContainer/FireMode1Btn
onready var fire_mode_2_button = $MarginContainer/MainContainer/SettingsContainer/FireModeContainer/FireMode2Btn
onready var fire_mode_3_button = $MarginContainer/MainContainer/SettingsContainer/FireModeContainer/FireMode3Btn

signal closed


func _ready():
	upgrades = get_parent().get_node("Upgrades")
	setup_tooltips()
	sync_descriptions()
	connect("closed", get_parent(), "_on_TowerMenu_closed")


func setup_tooltips():
	var projectiles_per_s = 1/upgrades.fire_rate_value
	fire_rate_desc.set_tooltip("Projectiles/s: " + str(projectiles_per_s))


func sync_descriptions():
	sync_fire_rate_desc(upgrades.fire_rate_lvl + 1)
	sync_fire_rate_cost(upgrades.fire_rate_upgrade_cost)
	sync_fire_range_desc(upgrades.fire_range_lvl + 1)
	sync_fire_range_cost(upgrades.fire_range_upgrade_cost)
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


func _on_FireRateBtn_pressed():
	upgrades.fire_rate_level_up()
	sync_fire_rate_desc(upgrades.fire_rate_lvl + 1)
	sync_fire_rate_cost(upgrades.fire_rate_upgrade_cost)
	setup_tooltips()


func _on_FireRangeBtn_pressed():
	upgrades.fire_range_level_up()
	sync_fire_range_desc(upgrades.fire_range_lvl + 1)
	sync_fire_range_cost(upgrades.fire_range_upgrade_cost)
	setup_tooltips()


func _on_ProjectileBtn_pressed():
	upgrades.projectile_level_up()
	sync_projectile_desc(upgrades.projectile_lvl + 1)
	sync_projectile_cost(upgrades.projectile_upgrade_cost)
	setup_tooltips()


func _on_FireMode1Btn_toggled(button_pressed):
	if button_pressed:
		get_parent().set_fire_mode(1)
		fire_mode_2_button.pressed = false
		fire_mode_3_button.pressed = false


func _on_FireMode2Btn_toggled(button_pressed):
	if button_pressed:
		get_parent().set_fire_mode(2)
		fire_mode_1_button.pressed = false
		fire_mode_3_button.pressed = false


func _on_FireMode3Btn_toggled(button_pressed):
	if button_pressed:
		get_parent().set_fire_mode(3)
		fire_mode_1_button.pressed = false
		fire_mode_2_button.pressed = false


func _on_CloseButton_pressed():
	hide()
	emit_signal("closed")

