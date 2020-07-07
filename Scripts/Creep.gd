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
			get_parent().creep_dead()
			queue_free()


func setup_stats():
	match Global.wave:
		0:
			value = 1
			hitpoints = 2
			speed = 70
		1:
			value = 2
			hitpoints = 4
			speed = 80
		2:
			value = 3
			hitpoints = 5
			speed = 90
		3:
			value = 5
			hitpoints = 7
			speed = 100
		4:
			value = 7
			hitpoints = 9
			speed = 110
		5:
			value = 9
			hitpoints = 12
			speed = 120
		6:
			value = 11
			hitpoints = 16
			speed = 130
		7:
			value = 13
			hitpoints = 20
			speed = 140
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
			get_parent().creep_dead()
			get_tree().call_group("Game", "add_cash", value)
			queue_free()

