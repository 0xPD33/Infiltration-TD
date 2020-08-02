extends Popup


func pause_game():
	show()
	get_tree().paused = true


func unpause_game():
	get_tree().paused = false
	hide()


func quit_prompt():
	$QuitDialog.popup_centered()


# this code should be level-independent:
func save_scene_state():
	var level_scene = get_parent().get_parent()
	
	# towers are not being saved yet because this doesn't seem to work:
#	var towers = level_scene.get_node("Towers")
#	towers.owner = level_scene
	
#	for tower in towers:
#		tower.owner = level_scene
	
	Global.current_scene_name = level_scene.name
	
	var packed_level = PackedScene.new()
	packed_level.pack(level_scene)
	
	var format_path = "res://Scenes/{Level}.tscn"
	var actual_path = format_path.format({"Level": level_scene.name}) 

	ResourceSaver.save(actual_path, packed_level)


func _on_ContinueButton_pressed():
	unpause_game()


func _on_RestartButton_pressed():
	unpause_game()
	get_tree().reload_current_scene()
	Global.reset()


func _on_SettingsButton_pressed():
	save_scene_state()
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


