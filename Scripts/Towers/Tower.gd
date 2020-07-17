extends Area2D

# BUILDING VARS

var tower_cost

var building = true
var selected = false setget set_selected
var colliding = false
var can_build = false
var can_select = false

var tower_space
var tilemap
var cell_size
var cell_position
var cell_id
var current_tile

# SHOOTING VARS

var enemy_array = []
var current_target = null
var target_position
var distance_to_target

var projectile_instance
var projectile = null
var shooting = false

var fire_rate
var fire_range

# fire modes don't work as expected as of right now

enum fire_mode {FIRE_MODE_FIRST, FIRE_MODE_LAST, FIRE_MODE_FAR}
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
	fire_range = $AggroRange/CollisionShape2D.get_shape().radius
	yield(get_tree(), "idle_frame")
	tilemap = get_parent().get_parent().get_node("TowerBases")
	cell_size = tilemap.cell_size


func _physics_process(delta: float):
	if building:
		_follow_mouse()
		show_range_circle(upgrades.fire_range_value)
		
		if can_build:
			$TurretTowerBase.modulate = Color(0.0, 1.0, 0.0, 0.7)
			$TurretTowerGun.modulate = Color(0.0, 1.0, 0.0, 0.7)
		else:
			$TurretTowerBase.modulate = Color(1.0, 0.0, 0.0, 0.7)
			$TurretTowerGun.modulate = Color(1.0, 0.0, 0.0, 0.7)
		
		if Input.is_action_just_pressed("left_click"):
			if can_build:
				building = false
				if "SingleTurretTower" in name:
					tower_cost = 150
					get_tree().call_group("Game", "tower_built", "SingleTurretTower", tower_cost)
				elif "LightBomberTower" in name:
					tower_cost = 500
					get_tree().call_group("Game", "tower_built", "LightBomberTower", tower_cost)
				elif "SniperTower" in name:
					tower_cost = 300
					get_tree().call_group("Game", "tower_built", "SniperTower", tower_cost)
				
				set_stats(false)
				hide_range_circle()
				$TurretTowerBase.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$TurretTowerGun.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		if current_target == null:
			current_target = choose_target()
			
			if current_target:
				$ShootTimer.start()
		else:
			if current_target == null:
				$ShootTimer.stop()
			else:
				target_position = current_target.get_global_transform().origin
				$TurretTowerGun.rotation = (target_position - position).angle() - deg2rad(-90)


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("left_click") and can_select and !building:
		set_selected(true)
	elif event.is_action_pressed("left_click") and !can_select and !building:
		set_selected(false)


func set_stats(upgraded):
	projectile = upgrades.projectile
	fire_rate = upgrades.fire_rate_value
	fire_range = upgrades.fire_range_value
	$ShootTimer.set_wait_time(fire_rate)
	$AggroRange/CollisionShape2D.get_shape().radius = fire_range
	
	if upgraded:
		hide_range_circle()
		show_range_circle(fire_range)
	elif !upgraded:
		set_fire_mode(1)


func set_fire_mode(mode):
	match mode:
		1:
			current_fire_mode = fire_mode.FIRE_MODE_FIRST
			tower_menu.fire_mode_1_button.pressed = true
		2:
			current_fire_mode = fire_mode.FIRE_MODE_LAST
			tower_menu.fire_mode_2_button.pressed = true
		3:
			current_fire_mode = fire_mode.FIRE_MODE_FAR
			tower_menu.fire_mode_3_button.pressed = true


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
	tower_menu.rect_position.x = pos.x - 125
	tower_menu.rect_position.y = pos.y - 275


func choose_target():
	var pos = get_global_transform().origin
	for enemy in enemy_array:
		if current_fire_mode == fire_mode.FIRE_MODE_FIRST:
			if pos.distance_to(enemy.get_global_transform().origin) <= fire_range:
				if (current_target == null or enemy.get_global_transform().origin >
					current_target.get_global_transform().origin):
						current_target = enemy
		
		elif current_fire_mode == fire_mode.FIRE_MODE_LAST:
			if pos.distance_to(enemy.get_global_transform().origin) <= fire_range:
				current_target = enemy_array.back()
		
		elif current_fire_mode == fire_mode.FIRE_MODE_FAR:
			if pos.distance_to(enemy.get_global_transform().origin) >= fire_range:
				if (current_target == null or enemy.get_global_transform().origin >
					current_target.get_global_transform().origin):
						current_target = enemy
	
	return current_target


func _follow_mouse():
	yield(get_tree().create_timer(0.03), "timeout")
	position = get_global_mouse_position()
	
	cell_position = Vector2(floor(position.x / cell_size.x),
							floor(position.y / cell_size.y))
	cell_id = tilemap.get_cellv(cell_position)
	
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
	if area.is_in_group("Enemy"):
		enemy_array.append(area.get_parent())


func _on_AggroRange_area_exited(area: Area2D):
	if area.is_in_group("Enemy"):
		enemy_array.erase(area.get_parent())
		if area.get_parent() == current_target:
			current_target = null


func _on_ShootTimer_timeout():
	if current_target:
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

