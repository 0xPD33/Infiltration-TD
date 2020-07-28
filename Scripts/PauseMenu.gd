extends Popup



func pause_game():
	show()
	get_tree().paused = true


func unpause_game():
	get_tree().paused = false
	hide()


func _on_ContinueButton_pressed():
	unpause_game()


func _on_SettingsButton_pressed():
	unpause_game()
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_QuitButton_pressed():
	unpause_game()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

