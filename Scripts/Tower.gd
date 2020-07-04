extends Area2D

# BUILDING VARS

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

var instance
var projectile = load("res://Scenes/Projectiles/Projectile1.tscn") 
var shooting = false

var fire_rate
var fire_range

onready var upgrades = $Upgrades
onready var range_circle = $TurretRange


func set_selected(value):
	if selected != value:
		selected = value
		select_tower()


func _ready():
	add_to_group("Tower")
	yield(get_tree(), "idle_frame")
	fire_range = $AggroRange/CollisionShape2D.get_shape().radius
	tilemap = get_parent().get_parent().get_node("TowerBases")
	cell_size = tilemap.cell_size


func _physics_process(delta: float):
	if building:
		_follow_mouse()
		
		if can_build:
			$TurretTowerBase.modulate = Color(0.0, 1.0, 0.0, 0.7)
			$TurretTowerGun.modulate = Color(0.0, 1.0, 0.0, 0.7)
		else:
			$TurretTowerBase.modulate = Color(1.0, 0.0, 0.0, 0.7)
			$TurretTowerGun.modulate = Color(1.0, 0.0, 0.0, 0.7)
		
		if Input.is_action_just_pressed("left_click"):
			if can_build:
				building = false
				get_tree().call_group("Game", "tower_built", "TurretTower")
				set_stats()
				$TurretTowerBase.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$TurretTowerGun.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		
		if !current_target:
			current_target = choose_target()
			
			if current_target:
				$ShootTimer.start()
		else:
			if (!current_target):
				$ShootTimer.stop()
			else:
				target_position = current_target.get_global_transform().origin
				$TurretTowerGun.rotation = (target_position - position).angle() - deg2rad(-90)
		
		if Input.is_action_just_pressed("left_click") and can_select:
			set_selected(true)
		elif Input.is_action_just_pressed("left_click") and !can_select:
			set_selected(false)


func set_stats():
	fire_rate = upgrades.get_vars("fire_rate_value")
	$ShootTimer.set_wait_time(fire_rate)


func select_tower():
	if selected:
		hide_range_circle()
		show_range_circle(fire_range)
		get_tree().call_group("HUD", "hide_upgrades")
		get_tree().call_group("HUD", "show_upgrades")
	elif !selected:
		hide_range_circle()
		get_tree().call_group("HUD", "hide_upgrades")


func choose_target():
	var pos = get_global_transform().origin
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if pos.distance_to(enemy.get_global_transform().origin) <= fire_range:
			if (current_target == null or enemy.get_global_transform().origin.x > 
				current_target.get_global_transform().origin.x):
					current_target = enemy
	return current_target


func _follow_mouse():
	yield(get_tree().create_timer(0.05), "timeout")
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
			$ShootTimer.stop()


func _on_ShootTimer_timeout():
	if current_target:
		instance = projectile.instance()
		instance.set_target(current_target)
		instance.position = $TurretTowerGun/ShotPosition.get_global_transform().origin
		get_parent().add_child(instance)


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

