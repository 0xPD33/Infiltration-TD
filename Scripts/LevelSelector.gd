extends Control

var level_1 = "res://Scenes/Level1.tscn"

var level_selected = null


func _on_Level1Button_toggled(button_pressed):
	if button_pressed:
		level_selected = level_1
	else:
		level_selected = null


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_NewGameButton_pressed():
	if level_selected:
		get_tree().change_scene(level_selected)


func _on_ContinueGameButton_pressed():
	if level_selected:
		SaveManager.load_game()
		if SaveManager.load_done:
			get_tree().change_scene(level_selected)

