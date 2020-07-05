extends PopupMenu

var upgrades

onready var fire_rate_desc = $StatsContainer/FireRateContainer/FireRateDesc
onready var fire_rate_cost_label = $StatsContainer/FireRateContainer/FireRateCostLabel

signal closed


func _ready():
	upgrades = get_parent().get_node("Upgrades")
	sync_fire_rate_desc(upgrades.fire_rate_lvl + 1)
	sync_fire_rate_cost(upgrades.fire_rate_upgrade_cost)
	connect("closed", get_parent(), "_on_TowerMenu_closed")


func _on_FireRateBtn_pressed():
	upgrades.fire_rate_level_up()
	sync_fire_rate_desc(upgrades.fire_rate_lvl + 1)
	sync_fire_rate_cost(upgrades.fire_rate_upgrade_cost)


func sync_fire_rate_desc(fire_rate_lvl):
	fire_rate_desc.text = "Fire Rate (Lvl." + str(fire_rate_lvl) + ")" 


func sync_fire_rate_cost(fire_rate_cost):
	fire_rate_cost_label.text = "Cost: " + str(fire_rate_cost)


func _on_CloseButton_pressed():
	hide()
	emit_signal("closed")

