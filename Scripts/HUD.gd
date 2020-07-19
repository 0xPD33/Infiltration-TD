extends Control


func _ready():
	add_to_group("HUD")
	setup_tooltips()
	sync_lives_label()
	sync_wave_label()
	sync_cash_label()


func setup_tooltips():
	$BuyRect/BuyPanel/HBoxContainer/StartWaveButton.set_tooltip("Start Wave")
	$BuyRect/BuyPanel/HBoxContainer/FastForwardButton.set_tooltip("Fast Forward (2x)")
	$BuyRect/BuyPanel/BuyButton1.set_tooltip("Buy Single Turret Tower - Cost: 150")
	$BuyRect/BuyPanel/BuyButton2.set_tooltip("Buy Light Bomber Tower - Cost: 500")
	$BuyRect/BuyPanel/BuyButton3.set_tooltip("Buy Sniper Tower - Cost: 300")
	$BuyRect/BuyPanel/BuyButton4.set_tooltip("Buy Double Turret Tower - Cost: 650")


func sync_lives_label():
	$HBoxContainer/LivesLabel.text = "Lives: " + str(Global.lives)


func sync_wave_label():
	$HBoxContainer/WaveLabel.text = "Wave: " + str(Global.wave)


func sync_cash_label():
	$HBoxContainer/CashLabel.text = "Cash: " + str(Global.cash)


func toggle_fast_forward_button():
	$BuyRect/BuyPanel/HBoxContainer/FastForwardButton.pressed = false


func _on_BuyButton1_pressed():
	if Global.cash >= 150:
		get_tree().call_group("Game", "buy_button_1")


func _on_BuyButton2_pressed():
	if Global.cash >= 500:
		get_tree().call_group("Game", "buy_button_2")


func _on_BuyButton3_pressed():
	if Global.cash >= 300:
		get_tree().call_group("Game", "buy_button_3")


func _on_BuyButton4_pressed():
	if Global.cash >= 650:
		get_tree().call_group("Game", "buy_button_4")


func _on_StartWaveButton_pressed():
	get_tree().call_group("Game", "start_wave")


func _on_FastForwardButton_toggled(button_pressed: bool):
	if button_pressed:
		get_tree().call_group("Game", "fast_forward", true)
	else:
		get_tree().call_group("Game", "fast_forward", false)


