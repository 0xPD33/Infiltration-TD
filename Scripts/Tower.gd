extends Area2D

# BUILDING VARS

var building = true
var selected = false
var colliding = false
var can_build = false
var can_select = false

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
var fire_range


func _ready():
	add_to_group("Tower")
	fire_range = $AggroRange/CollisionShape2D.get_shape().radius
	tilemap = get_parent().get_node("TowerBases")
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
				get_tree().call_group("Game", "tower_built", "TurretTower1")
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


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			if can_select and !building:
				selected = true
				$CanvasLayer/UpgradesPopup.rect_position.x = get_position().x
				$CanvasLayer/UpgradesPopup.rect_position.y = get_position().y
				get_tree().call_group("Upgrades", "_setup_vars")
				$CanvasLayer/UpgradesPopup.show()


func choose_target():
	var pos = get_global_transform().origin
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if pos.distance_to(enemy.get_global_transform().origin) <= fire_range:
			if (current_target == null or enemy.get_global_transform().origin.x > 
				current_target.get_global_transform().origin.x):
					current_target = enemy
	return current_target


func _follow_mouse():
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


func _on_TurretTower1_mouse_entered():
	can_select = true


func _on_TurretTower1_mouse_exited():
	can_select = false

