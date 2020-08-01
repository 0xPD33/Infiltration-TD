extends Area2D

# All towers are handled in this script

# BUILDING VARS

var tower_cost

# currently building?
var building = true

var selected = false setget set_selected

# colliding with another tower?
var colliding = false

var can_build = false
var can_select = false

var tilemap
var cell_size
var cell_position
var cell_id
var current_tile

# SHOOTING VARS

# enemies in tower range will be added to this array
var enemy_array = []

# the sniper tower has it's own enemy array
# (my plan is to add enemies only the sniper tower can see)
var sniper_enemy_array = []

var current_target = null
var target_position
var distance_to_target

var projectile_instance
var projectile = null
var shooting = false

var fire_rate
var fire_range

enum fire_mode {FIRE_MODE_FIRST, FIRE_MODE_LAST}
var current_fire_mode

onready var upgrades = $Upgrades
onready var tower_menu = $TowerMenu
onready var range_circle = $TurretRange


func set_selected(value):
	if selected != value:
		selected = value
		tower_select_state()


func _ready():
	add_to_group("Tower")
	
	# set the starting fire range equal to the radius of the AggroRange's CollisionShape2D node
	fire_range = $AggroRange/CollisionShape2D.get_shape().radius
	yield(get_tree(), "idle_frame")
	
	# get the TowerBases tilemap node from the level scene
	tilemap = get_parent().get_parent().get_node("TowerBases")
	cell_size = tilemap.cell_size


func _physics_process(delta: float):
	# towers start out in building mode once they are instantiated
	if building:
		_follow_mouse()
		
		# show the tower range while building
		show_range_circle(upgrades.fire_range_value)
		
		# change modulate values of the tower
		if can_build:
			# change colors to green
			$TurretTowerBase.modulate = Color(0.0, 1.0, 0.0, 0.7)
			$TurretTowerGun.modulate = Color(0.0, 1.0, 0.0, 0.7)
		else:
			# change colors to red
			$TurretTowerBase.modulate = Color(1.0, 0.0, 0.0, 0.7)
			$TurretTowerGun.modulate = Color(1.0, 0.0, 0.0, 0.7)
		
		if Input.is_action_just_pressed("left_click"):
			if can_build:
				# place the tower
				building = false
				
				# check for nodes name and depending on that set the tower cost
				# and call the function "tower_built" in the "Game" group (Game.gd),
				# passing the name and tower cost
				if "SingleTurretTower" in name:
					tower_cost = 150
					get_tree().call_group("Game", "tower_built", "SingleTurretTower", tower_cost)
				elif "LightBomberTower" in name:
					tower_cost = 500
					get_tree().call_group("Game", "tower_built", "LightBomberTower", tower_cost)
				elif "SniperTower" in name:
					tower_cost = 300
					get_tree().call_group("Game", "tower_built", "SniperTower", tower_cost)
				elif "DoubleTurretTower" in name:
					tower_cost = 650
					get_tree().call_group("Game", "tower_built", "DoubleTurretTower", tower_cost)
				
				tower_menu.set_sell_value(tower_cost)
				
				# set stats (not upgraded)
				set_stats(false)
				hide_range_circle()
				
				# reset tower modulate values
				$TurretTowerBase.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$TurretTowerGun.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		if current_target == null:
			if not "SniperTower" in name:
				current_target = choose_target(enemy_array)
			else:
				current_target = choose_target(sniper_enemy_array)
			
			if current_target:
				$ShootTimer.start()
		else:
			if current_target == null:
				$ShootTimer.stop()
			else:
				# keep track of the target_position
				target_position = current_target.get_global_transform().origin
				
				# rotate the tower's gun
				$TurretTowerGun.rotation = (target_position - position).angle() - deg2rad(-90)


# the only input function that works for selecting towers.
# _input() and _input_event() functions did not work
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("left_click") and can_select and !building:
		set_selected(true)
	elif event.is_action_pressed("left_click") and !can_select and !building:
		set_selected(false)


func set_stats(upgraded):
	# set the towers stats to the values from the Upgrades node and it's script (Upgrades.gd)
	projectile = upgrades.projectile
	fire_rate = upgrades.fire_rate_value
	fire_range = upgrades.fire_range_value
	$ShootTimer.set_wait_time(fire_rate)
	$AggroRange/CollisionShape2D.get_shape().radius = fire_range
	
	if upgraded:
		# hide and show the tower's range when the tower was just upgraded
		hide_range_circle()
		show_range_circle(fire_range)
	elif !upgraded:
		set_fire_mode(1)


# set the fire mode, which controls which enemy the tower targets
func set_fire_mode(mode):
	match mode:
		1:
			current_fire_mode = fire_mode.FIRE_MODE_FIRST
			tower_menu.fire_mode_1_button.pressed = true
		2:
			current_fire_mode = fire_mode.FIRE_MODE_LAST
			tower_menu.fire_mode_2_button.pressed = true


func tower_select_state():
	if selected:
		select_tower()
	elif !selected:
		deselect_tower()


func select_tower():
	hide_range_circle()
	show_range_circle(fire_range)
	set_tower_menu_pos(get_global_transform().origin)
	tower_menu.show()


func deselect_tower():
	hide_range_circle()
	tower_menu.hide()


func set_tower_menu_pos(pos):
	# MidPosition is a node in the level scene with the position always set to the center of the screen
	# depending on where you click the tower menu's position changes
	# this is to prevent the tower menu from going off screen
	if get_global_transform().origin.x < get_parent().get_parent().get_node("MidPosition").global_transform.origin.x:
		tower_menu.rect_position.x = pos.x + 50
		tower_menu.rect_position.y = pos.y - 125
	else:
		tower_menu.rect_position.x = pos.x - 350
		tower_menu.rect_position.y = pos.y - 125


# code for choosing a target for the tower
func choose_target(array):
	var pos = get_global_transform().origin
	distance_to_target = fire_range
	for enemy in array:
		if current_fire_mode == fire_mode.FIRE_MODE_FIRST:
			if (position - enemy.get_global_transform().origin).length() <= distance_to_target:
				current_target = enemy
				target_position = enemy.get_global_transform().origin
				distance_to_target = (position - target_position).length()
		
		elif current_fire_mode == fire_mode.FIRE_MODE_LAST:
			if pos.distance_to(enemy.get_global_transform().origin) <= fire_range:
				current_target = array.back()
	
	return current_target


# I don't fully understand the following code. It was taken from a tower defense tutorial by LegionGames on YT.
func _follow_mouse():
	# wait for a very short period of time before running this code
	# not doing this crashed the game, unsure why
	yield(get_tree().create_timer(0.03), "timeout")
	
	# make the tower follow the mouse
	position = get_global_mouse_position()
	
	cell_position = Vector2(floor(position.x / cell_size.x),
							floor(position.y / cell_size.y))
	cell_id = tilemap.get_cellv(cell_position)
	
	# the TowerBases tilemap node has only one tile which has it's name set to tower_base
	# the following code checks if the current tile you are hovering over is such a tile
	# and if so sets can_build to true
	if cell_id != -1 && !colliding:
		current_tile = tilemap.tile_set.tile_get_name(cell_id)
		if current_tile == "tower_base":
			can_build = true
			position = Vector2	(cell_position.x * cell_size.x + cell_size.x / 2,
								cell_position.y * cell_size.y + cell_size.y / 2)
	else:
		can_build = false


func show_range_circle(turret_range):
	range_circle.set_scale(Vector2(turret_range/100.0, turret_range/100.0))
	range_circle.show()


func hide_range_circle():
	range_circle.hide()


func _on_AggroRange_area_entered(area: Area2D):
	if "SniperTower" in name:
		if area.is_in_group("HiddenEnemy"):
			sniper_enemy_array.append(area.get_parent())
		if area.is_in_group("Enemy"):
			sniper_enemy_array.append(area.get_parent())
	else:
		if area.is_in_group("Enemy"):
			enemy_array.append(area.get_parent())



func _on_AggroRange_area_exited(area: Area2D):
	if "SniperTower" in name:
		if area.is_in_group("HiddenEnemy"):
			sniper_enemy_array.erase(area.get_parent())
			if area.get_parent() == current_target:
				current_target = null
		if area.is_in_group("Enemy"):
			sniper_enemy_array.erase(area.get_parent())
			if area.get_parent() == current_target:
				current_target = null
	else:
		if area.is_in_group("Enemy"):
			enemy_array.erase(area.get_parent())
			if area.get_parent() == current_target:
				current_target = null


# the actual code responsible for shooting and spawning projectiles
func _on_ShootTimer_timeout():
	if current_target:
		if "DoubleTurretTower" in name:
			
			# need to find another solution of shooting two projectiles at once (with a small delay)
			# because this is really bad: 
			
			projectile_instance = projectile.instance()
			projectile_instance.set_target(current_target)
			projectile_instance.position = $TurretTowerGun/ShotPosition.get_global_transform().origin
			get_parent().get_parent().add_child(projectile_instance)
			
			yield(get_tree().create_timer(0.1), "timeout")
			
			var projectile_instance_2 = projectile.instance()
			projectile_instance_2.set_target(current_target)
			projectile_instance_2.position = $TurretTowerGun/ShotPosition2.get_global_transform().origin
			get_parent().get_parent().add_child(projectile_instance_2)
		else:
			projectile_instance = projectile.instance()
			projectile_instance.set_target(current_target)
			projectile_instance.position = $TurretTowerGun/ShotPosition.get_global_transform().origin
			get_parent().get_parent().add_child(projectile_instance)


func _on_TurretTower1_area_entered(area: Area2D):
	if area.is_in_group("Tower"):
		colliding = true


func _on_TurretTower1_area_exited(area: Area2D):
	if area.is_in_group("Tower"):
		colliding = false


func _on_mouse_entered():
	can_select = true


func _on_mouse_exited():
	can_select = false


func _on_TowerMenu_closed():
	set_selected(false)

