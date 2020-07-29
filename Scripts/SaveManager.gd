extends Node

# doesn't load or save towers yet,
# check save_progress() in Game.gd

var save_done = false
var load_done = false


func save_game():
	var save = File.new()
	save.open("user://savegame.save", File.WRITE)
	var current_game = get_tree().get_nodes_in_group("Game")
	
	for node in current_game:
		if node.has_method("save_progress"):
			var node_data = node.call("save_progress")
			save.store_line(to_json(node_data))
			
	save.close()
	save_done = true


func load_game():
	var save = File.new()
	
	if not save.file_exists("user://savegame.save"):
		return
	
	save.open("user://savegame.save", File.READ)
	
	while save.get_position() < save.get_len():
		var node_data = parse_json(save.get_line())
		
		for i in node_data.keys():
			i = node_data[i]
	
	save.close()
	load_done = true

