extends Node

var save_done
var load_done

var just_loaded = false


func save_game():
	save_done = false
	var save = File.new()
	save.open("user://savegame.save", File.WRITE)
	var game_nodes = get_tree().get_nodes_in_group("Game")
	
	for node in game_nodes:
		if node.has_method("save_progress"):
			var game_data = node.call("save_progress")
			save.store_line(to_json(game_data))
	
	var tower_nodes = get_tree().get_nodes_in_group("Tower")
	
	for node in tower_nodes:
		if node.has_method("save_progress"):
			var tower_data = node.call("save_progress")
			save.store_line(to_json(tower_data))
	
	save.close()
	save_done = true


func load_game():
	load_done = false
	var save = File.new()
	
	if not save.file_exists("user://savegame.save"):
		return
	
	save.open("user://savegame.save", File.READ)
	
	while save.get_position() < save.get_len():
		var game_data = parse_json(save.get_line())
		
		for i in game_data.keys():
			i = game_data[i]
		
		var tower_data = parse_json(save.get_line())
		
		var new_object = load(tower_data["filename"]).instance()
		get_node(tower_data["parent"]).add_child(new_object)
		new_object.position = Vector2(tower_data["pos_x"], tower_data["pos_y"])
		
		for i in tower_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, tower_data[i])
	
	save.close()
	load_done = true

