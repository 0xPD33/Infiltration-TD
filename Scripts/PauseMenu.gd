extends Popup


func pause_game():
	show()
	get_tree().paused = true


func unpause_game():
	get_tree().paused = false
	hide()


func quit_prompt():
	$QuitDialog.popup_centered()


func _on_ContinueButton_pressed():
	unpause_game()


func _on_RestartButton_pressed():
	unpause_game()
	get_tree().reload_current_scene()
	Global.reset()


func _on_SettingsButton_pressed():
	unpause_game()
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_QuitButton_pressed():
	quit_prompt()
	hide()


func _on_NoButton_pressed():
	$QuitDialog.hide()
	show()


func _on_YesButton_pressed():
	unpause_game()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


