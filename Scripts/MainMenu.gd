extends Control

onready var play_label = $MainContainer/MenuContainer/PlayButton/PlayLabel
onready var settings_label = $MainContainer/MenuContainer/SettingsButton/SettingsLabel
onready var credits_label = $MainContainer/MenuContainer/CreditsButton/CreditsLabel
onready var quit_label = $MainContainer/MenuContainer/QuitButton/QuitLabel


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/LevelSelector.tscn")


func _on_SettingsButton_pressed():
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_CreditsButton_pressed():
	pass # go to credits screen


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_mouse_entered():
	$PlayHoverAnim.play("play_hover_in")


func _on_PlayButton_mouse_exited():
	$PlayHoverAnim.play("play_hover_out")


func _on_SettingsButton_mouse_entered():
	$SettingsHoverAnim.play("settings_hover_in")


func _on_SettingsButton_mouse_exited():
	$SettingsHoverAnim.play("settings_hover_out")


func _on_CreditsButton_mouse_entered():
	$CreditsHoverAnim.play("credits_hover_in")


func _on_CreditsButton_mouse_exited():
	$CreditsHoverAnim.play("credits_hover_out")


func _on_QuitButton_mouse_entered():
	$QuitHoverAnim.play("quit_hover_in")


func _on_QuitButton_mouse_exited():
	$QuitHoverAnim.play("quit_hover_out")

