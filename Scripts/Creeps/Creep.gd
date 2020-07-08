extends PathFollow2D

var dead = false
var speed : float
var hitpoints : float
var value


func _physics_process(delta):
	creep_move(delta)
	
	if unit_offset >= 1:
		if not dead:
			dead = true
			get_tree().call_group("Game", "lose_live")
			get_parent().creep_dead()
			queue_free()


func creep_move(delta):
	offset += speed * delta


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group("Projectile"):
		hitpoints -= area.damage
		area.queue_free()
		if hitpoints <= 0:
			dead = true
			get_parent().creep_dead()
			get_tree().call_group("Game", "add_cash", value)
			queue_free()

