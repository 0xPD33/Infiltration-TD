extends Control

const DEV_COMMANDS = ["help"]

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


func update_log(text):
	console_log.bbcode_text += text 


func _on_CommandLine_text_entered(command):
	if command in DEV_COMMANDS:
		update_log(">> " + command + "\n")
		match command:
			"help":
				show_help()
	
	command_line.text = ""

