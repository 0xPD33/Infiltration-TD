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
			value = 5
			hitpoints = 10
			speed = 100
		1:
			value = 7
			hitpoints = 12
			speed = 110
		2:
			value = 9
			hitpoints = 15
			speed = 120
		3:
			value = 10
			hitpoints = 15
			speed = 125
		4:
			value = 12
			hitpoints = 18
			speed = 130
		5:
			value = 13
			hitpoints = 20
			speed = 135


func creep_move(delta):
	offset += speed * delta


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group("Projectile"):
		area.queue_free()
		hitpoints -= 1
		if hitpoints <= 0:
			dead = true
			get_tree().call_group("Spawner", "creep_dead")
			get_tree().call_group("Game", "add_cash", value)
			queue_free()

