extends Control

var animations
var healthbar_enabled
var damage_numbers_enabled

onready var animations_option_button = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/AnimationsContainer/AnimationsOptionButton
onready var healthbar_checkbox = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/CheckBoxContainer/HealthBarCheckBox
onready var damage_numbers_checkbox = $MainContainer/SettingsTabContainer/Graphics/GraphicsContainer/CheckBoxContainer/DamageNumbersCheckBox


func _ready():
	match_global_values()


func match_global_values():
	if Global.animations:
		animations = true
		animations_option_button.selected = 0
	else:
		animations = false
		animations_option_button.selected = 1
	
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


func apply_settings():
	if animations:
		Global.animations = true
	else:
		Global.animations = false
	
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


func _on_AnimationsOptionButton_item_selected(index):
	if index == 0:
		animations = true
	elif index == 1:
		animations = false

