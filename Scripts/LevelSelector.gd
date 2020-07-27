extends Control

var level_1 = "res://Scenes/Level1.tscn"

var level_selected = null


func _on_Level1Button_toggled(button_pressed):
	if button_pressed:
		level_selected = level_1
	else:
		level_selected = null


func _on_PlayLevelButton_pressed():
	get_tree().change_scene(level_selected)


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

