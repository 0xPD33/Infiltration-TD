extends PopupMenu

onready var upgrades = get_parent().get_node("Upgrades")
onready var fire_rate_desc = $StatsContainer/FireRateContainer/FireRateDesc

signal closed


func _ready():
	connect("closed", get_parent(), "_on_TowerMenu_closed")


func _on_FireRateBtn_pressed():
	upgrades.fire_rate_level_up()
	sync_fire_rate_desc(upgrades.get_var("fire_rate_lvl"))


func sync_fire_rate_desc(fire_rate_lvl):
	fire_rate_desc.text = "Fire Rate (Lvl." + str(fire_rate_lvl) + ")" 


func _on_CloseButton_pressed():
	hide()
	emit_signal("closed")

