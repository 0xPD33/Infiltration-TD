extends Control

var animations
var screen_shakes
var healthbar_enabled
var damage_numbers_enabled

var tooltip

onready var animations_option_button = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/AnimationsContainer/AnimationsOptionButton
onready var screen_shakes_checkbox = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/CheckBoxContainer/ScreenShakesCheckBox
onready var healthbar_checkbox = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/CheckBoxContainer/HealthBarCheckBox
onready var damage_numbers_checkbox = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/CheckBoxContainer/DamageNumbersCheckBox


func _ready():
	match_global_values()
	create_tooltips()


func match_global_values():
	if Global.animations:
		animations = true
		animations_option_button.selected = 0
	else:
		animations = false
		animations_option_button.selected = 1
	
	if Global.screen_shakes:
		screen_shakes = true
		screen_shakes_checkbox.pressed = true
	else:
		screen_shakes = false
		screen_shakes_checkbox.pressed = false
	
	if Global.healthbar_enabled:
		healthbar_enabled = true
		healthbar_checkbox.pressed = true
	else:
		healthbar_enabled = false
		healthbar_checkbox.pressed = false
	
	if Global.damage_numbers_enabled:
		damage_numbers_enabled = true
		damage_numbers_checkbox.pressed = true
	else:
		damage_numbers_enabled = false
		damage_numbers_checkbox.pressed = false


func create_tooltips():
	var settings_available = [animations_option_button, screen_shakes_checkbox, healthbar_checkbox, damage_numbers_checkbox]
	for setting in settings_available:
		tooltip = load("res://Scenes/TooltipSetting.tscn").instance()
		tooltip.hide()
		
		if setting == settings_available.front():
			tooltip.rect_position.x = setting.rect_position.x - 310
			tooltip.rect_position.y = setting.rect_position.y - 70
		else:
			tooltip.rect_position.x = setting.rect_position.x - 175
		
		setting.add_child(tooltip)
	
	var animations_description = animations_option_button.get_node("TooltipSetting/CenterContainer/TooltipPanel/SettingDescription")
	var screen_shakes_description = screen_shakes_checkbox.get_node("TooltipSetting/CenterContainer/TooltipPanel/SettingDescription")
	var healthbar_description = healthbar_checkbox.get_node("TooltipSetting/CenterContainer/TooltipPanel/SettingDescription")
	var damage_numbers_description = damage_numbers_checkbox.get_node("TooltipSetting/CenterContainer/TooltipPanel/SettingDescription")
	
	animations_description.text = "Turn Animations like enemies walking or getting hurt on or off."
	screen_shakes_description.text = "Turn screen shakes on or off. (They happen when something goes boom.)"
	healthbar_description.text = "Enable or disable the enemy healthbar. It floats above an enemy once it first gets hurt."
	damage_numbers_description.text = "Enable or disable the damage numbers which pop up when an enemy gets hurt."


func apply_settings():
	if animations:
		Global.animations = true
	else:
		Global.animations = false
	
	if screen_shakes:
		Global.screen_shakes = true
	else:
		Global.screen_shakes = false
	
	if healthbar_enabled:
		Global.healthbar_enabled = true
	else:
		Global.healthbar_enabled = false
	
	if damage_numbers_enabled:
		Global.damage_numbers_enabled = true
	else:
		Global.damage_numbers_enabled = false


func _on_ApplyButton_pressed():
	apply_settings()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_AnimationsOptionButton_item_selected(index):
	if index == 0:
		animations = true
	elif index == 1:
		animations = false


func _on_ScreenShakesCheckBox_toggled(button_pressed: bool):
	if button_pressed:
		screen_shakes = true
	else:
		screen_shakes = false


func _on_HealthBarCheckBox_toggled(button_pressed):
	if button_pressed:
		healthbar_enabled = true
	else:
		healthbar_enabled = false


func _on_DamageNumbersCheckBox_toggled(button_pressed):
	if button_pressed:
		damage_numbers_enabled = true
	else:
		damage_numbers_enabled = false


func _on_AnimationsLabel_mouse_entered():
	animations_option_button.get_node("TooltipSetting").show_tooltip(true)


func _on_AnimationsLabel_mouse_exited():
	animations_option_button.get_node("TooltipSetting").show_tooltip(false)


func _on_ScreenShakesCheckBox_mouse_entered():
	screen_shakes_checkbox.get_node("TooltipSetting").show_tooltip(true)


func _on_ScreenShakesCheckBox_mouse_exited():
	screen_shakes_checkbox.get_node("TooltipSetting").show_tooltip(false)


func _on_HealthBarCheckBox_mouse_entered():
	healthbar_checkbox.get_node("TooltipSetting").show_tooltip(true)


func _on_HealthBarCheckBox_mouse_exited():
	healthbar_checkbox.get_node("TooltipSetting").show_tooltip(false)


func _on_DamageNumbersCheckBox_mouse_entered():
	damage_numbers_checkbox.get_node("TooltipSetting").show_tooltip(true)


func _on_DamageNumbersCheckBox_mouse_exited():
	damage_numbers_checkbox.get_node("TooltipSetting").show_tooltip(false)
