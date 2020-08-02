extends Control


func _input(event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

