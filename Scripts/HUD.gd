extends Control

var tooltip_instance
var buy_tooltips = []

onready var buy_btn_1 = $BuyPanel/GridContainer/BuyButton1
onready var buy_btn_2 = $BuyPanel/GridContainer/BuyButton2
onready var buy_btn_3 = $BuyPanel/GridContainer/BuyButton3
onready var buy_btn_4 = $BuyPanel/GridContainer/BuyButton4


func _ready():
	add_to_group("HUD")
	create_tooltips()
	setup_tooltips()
	sync_lives_label()
	sync_wave_label()
	sync_cash_label()


func create_tooltips():
	var buy_buttons = [buy_btn_1, buy_btn_2, buy_btn_3, buy_btn_4]
	for btn in buy_buttons:
		tooltip_instance = load("res://Scenes/TooltipTowerCost.tscn").instance()
		tooltip_instance.hide()
		tooltip_instance.rect_position = $BuyTooltips.get_global_transform().origin
		tooltip_instance.set_name("BuyTooltip" + str(buy_tooltips.size()))
		buy_tooltips.append(tooltip_instance)
		$BuyTooltips.add_child(tooltip_instance)


func setup_tooltips():
	var buy_label_1 = buy_tooltips[0].get_node("CenterContainer/TooltipPanel/CostLabel")
	var buy_label_2 = buy_tooltips[1].get_node("CenterContainer/TooltipPanel/CostLabel")
	var buy_label_3 = buy_tooltips[2].get_node("CenterContainer/TooltipPanel/CostLabel")
	var buy_label_4 = buy_tooltips[3].get_node("CenterContainer/TooltipPanel/CostLabel")

	buy_label_1.text = "Buy Single Turret Tower - Cost: 150"
	buy_label_2.text = "Buy Light Bomber Tower - Cost: 500"
	buy_label_3.text = "Buy Sniper Tower - Cost: 300"
	buy_label_4.text = "Buy Double Turret Tower - Cost: 650"


func sync_lives_label():
	$HBoxContainer/LivesLabel.text = "Lives: " + str(Global.lives)


func sync_wave_label():
	$HBoxContainer/WaveLabel.text = "Wave: " + str(Global.wave)


func sync_cash_label():
	$HBoxContainer/CashLabel.text = "Cash: " + str(Global.cash)


func toggle_fast_forward_button():
	$ButtonPanel/HBoxContainer/FastForwardButton.pressed = false


func hud_toggle(is_visible):
	if is_visible:
		visible = true
	else:
		visible = false


func show_won_label():
	$WonLabel.visible = true


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


func _on_BuyButton1_mouse_entered():
	buy_tooltips[0].show_tooltip(true)


func _on_BuyButton1_mouse_exited():
	buy_tooltips[0].show_tooltip(false)


func _on_BuyButton2_mouse_entered():
	buy_tooltips[1].show_tooltip(true)


func _on_BuyButton2_mouse_exited():
	buy_tooltips[1].show_tooltip(false)


func _on_BuyButton3_mouse_entered():
	buy_tooltips[2].show_tooltip(true)


func _on_BuyButton3_mouse_exited():
	buy_tooltips[2].show_tooltip(false)


func _on_BuyButton4_mouse_entered():
	buy_tooltips[3].show_tooltip(true)


func _on_BuyButton4_mouse_exited():
	buy_tooltips[3].show_tooltip(false)

