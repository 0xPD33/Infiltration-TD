extends Popup

var projectiles_per_s : float

var fire_rate_value : float
var fire_rate_lvl : int

var fire_range_value : float
var fire_range_lvl : int

var fire_rate_upgrade_cost : int
var fire_range_upgrade_cost : int

var fire_rate_tooltip_value : String

onready var fire_rate_upgrade_btn = $PanelContainer/StatsContainer/FireRateContainer/UpgradeButton
onready var fire_rate_description = $PanelContainer/StatsContainer/FireRateContainer/FireRateDesc


func set_values(rate_val, rate_lvl, rate_cost, range_val, range_lvl, range_cost):
	fire_rate_value = rate_val
	fire_rate_lvl = rate_lvl
	fire_range_value = range_val
	fire_range_lvl = range_lvl
	
	fire_rate_upgrade_cost = rate_cost
	fire_range_upgrade_cost = range_cost
	
	_setup_tooltips()
	_update_description()


func _setup_tooltips():
	fire_rate_tooltip_value = str(_calc_tooltip_value())
	fire_rate_upgrade_btn.set_tooltip(fire_rate_tooltip_value)


func _calc_tooltip_value():
	projectiles_per_s = 1/fire_rate_value
	
	return projectiles_per_s


func _update_description():
	fire_rate_description.text = ("Fire Rate: " + str(fire_rate_tooltip_value) +
	 " projectiles/s " + "(Lv." + str(fire_rate_lvl) + ")")


func _disable_buttons():
	if Global.cash < fire_rate_upgrade_cost:
		fire_rate_upgrade_btn.disabled = true
	else:
		fire_rate_upgrade_btn.disabled = false


func _on_UpgradeButton_pressed():
	get_tree().call_group("Upgrades", "fire_rate_level_up")
	_setup_tooltips()
	_update_description()


func _on_CloseButton_pressed():
	hide()

