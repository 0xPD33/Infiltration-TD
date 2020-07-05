extends Control

onready var FireRateDesc = $BuyRect/UpgradeRect/UpgradePanel/VBoxContainer/HBoxContainer/FireRateDesc


func _ready():
	add_to_group("HUD")
	setup_tooltips()
	sync_lives_label()
	sync_wave_label()
	sync_cash_label()


func setup_tooltips():
	$BuyRect/BuyPanel/BuyButton1.set_tooltip("Buy Single Turret Tower. Cost: 50")


func sync_lives_label():
	$HBoxContainer/LivesLabel.text = "Lives: " + str(Global.lives)


func sync_wave_label():
	$HBoxContainer/WaveLabel.text = "Wave: " + str(Global.wave + 1)


func sync_cash_label():
	$HBoxContainer/CashLabel.text = "Cash: " + str(Global.cash)


func _on_BuyButton1_pressed():
	if Global.cash >= 50:
		get_tree().call_group("Game", "buy_button_1")


func _on_StartWaveButton_pressed():
	get_tree().call_group("Game", "start_wave")

