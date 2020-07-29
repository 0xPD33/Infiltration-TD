extends Popup


func pause_game():
	show()
	get_tree().paused = true


func unpause_game():
	get_tree().paused = false
	hide()


func save_prompt():
	$SaveGameDialog.popup_centered()


func _on_ContinueButton_pressed():
	unpause_game()


func _on_SettingsButton_pressed():
	unpause_game()
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_QuitButton_pressed():
	save_prompt()
	hide()


func _on_NoButton_pressed():
	unpause_game()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_YesButton_pressed():
	SaveManager.save_game()
	if SaveManager.save_done:
		unpause_game()
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

