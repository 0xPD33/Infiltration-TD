extends PathFollow2D

var dead = false
var speed : float
var hitpoints
var value


func _ready():
	setup_stats()


func _physics_process(delta):
	creep_move(delta)
	
	if unit_offset >= 1:
		if not dead:
			dead = true
			get_tree().call_group("Game", "lose_live")
			get_tree().call_group("Spawner", "creep_dead")
			queue_free()


func setup_stats():
	match Global.wave:
		0:
			value = 3
			hitpoints = 3
			speed = 70
		1:
			value = 5
			hitpoints = 6
			speed = 80
		2:
			value = 7
			hitpoints = 9
			speed = 90
		3:
			value = 9
			hitpoints = 12
			speed = 105
		4:
			value = 12
			hitpoints = 14
			speed = 120
		5:
			value = 15
			hitpoints = 18
			speed = 135
		6:
			value = 18
			hitpoints = 21
			speed = 150
		_:
			value = value + 2
			hitpoints = hitpoints + 2
			speed = speed + 2


func creep_move(delta):
	offset += speed * delta


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group("Projectile"):
		area.queue_free()
		hitpoints -= area.damage
		if hitpoints <= 0:
			dead = true
			get_tree().call_group("Spawner", "creep_dead")
			get_tree().call_group("Game", "add_cash", value)
			queue_free()

