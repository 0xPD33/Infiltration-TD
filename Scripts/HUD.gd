extends Control


func _ready():
	add_to_group("HUD")
	sync_lives_label()
	sync_wave_label()
	sync_cash_label()
	panel_fade_in()


func sync_lives_label():
	$HBoxContainer/LivesLabel.text = "Lives: " + str(Global.lives)


func sync_wave_label():
	$HBoxContainer/WaveLabel.text = "Wave: " + str(Global.wave + 1)


func sync_cash_label():
	$HBoxContainer/CashLabel.text = "Cash: " + str(Global.cash)


func panel_fade_in():
	$BuyPanel/AnimationPlayer.play("fade_in")


func panel_fade_out():
	$BuyPanel/AnimationPlayer.play("fade_out")


func _on_BuyButton1_pressed():
	get_tree().call_group("Game", "buy_button_1")


func _on_StartWaveButton_pressed():
	get_tree().call_group("Game", "start_wave")
	panel_fade_out()

