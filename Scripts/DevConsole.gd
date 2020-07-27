extends Control

const DEV_COMMANDS = ["help", "cash", "wave", "hud"]

var cash_amount
var current_wave
var hud_toggled = true

var entering_cash
var entering_wave
var value_entered

var opened = false

onready var console_log = $ConsolePanel/VBoxContainer/ConsoleLog
onready var command_line = $ConsolePanel/CommandLine


func _ready():
	add_to_group("DevConsole")
	visible = false


func open():
	visible = true
	$AnimationPlayer.play("dev_console_open")
	yield($AnimationPlayer, "animation_finished")
	opened = true
	command_line.grab_focus()


func close():
	$AnimationPlayer.play("dev_console_close")
	yield($AnimationPlayer, "animation_finished")
	opened = false
	visible = false


func error():
	update_log("\nSomething went wrong.\n")


func show_help():
	update_log("This is a development console used for testing purposes. Available commands:\n")
	for command in DEV_COMMANDS:
		update_log(command + ", ")
	
	update_log("\n")


func cash():
	value_entered = false
	entering_cash = true
	update_log("Enter amount: ")
	yield(command_line, "text_entered")
	entering_cash = false
	value_entered = true
	update_log(cash_amount + "\n")
	get_tree().call_group("Game", "add_cash", int(cash_amount))


func wave():
	value_entered = false
	entering_wave = true
	update_log("Attention: the wave increments by 1 after pressing play.\n")
	update_log("Enter wave: ")
	yield(command_line, "text_entered")
	entering_wave = false
	value_entered = true
	update_log(current_wave + "\n")
	Global.wave = current_wave
	get_tree().call_group("HUD", "sync_wave_label")


func hud():
	if hud_toggled:
		update_log("HUD toggled off.\n")
		hud_toggled = false
	else:
		update_log("HUD toggled on.\n")
		hud_toggled = true
	
	get_tree().call_group("HUD", "hud_toggle", hud_toggled)


func update_log(text):
	console_log.bbcode_text += text 


func _on_CommandLine_text_entered(command):
	if command in DEV_COMMANDS:
		update_log(">> " + command + "\n")
		match command:
			"help":
				show_help()
			"cash":
				cash()
			"wave":
				wave()
			"hud":
				hud()
	
	if !value_entered:
		if entering_cash:
			cash_amount = command
		elif entering_wave:
			current_wave = command
	
	command_line.text = ""

