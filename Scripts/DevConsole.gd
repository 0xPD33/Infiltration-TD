extends Control

const DEV_COMMANDS = ["help", "cash"]

var cash_amount_entered
var cash_amount

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


func show_help():
	update_log("This is a development console used for testing purposes. Available commands:\n")
	for command in DEV_COMMANDS:
		update_log(command + ", ")
	
	update_log("\n")


func cash():
	cash_amount_entered = false
	update_log("Enter amount: ")
	yield(command_line, "text_entered")
	cash_amount_entered = true
	update_log(cash_amount + "\n")
	get_tree().call_group("Game", "add_cash", int(cash_amount))


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
	
	if !cash_amount_entered:
		cash_amount = command
	
	command_line.text = ""

