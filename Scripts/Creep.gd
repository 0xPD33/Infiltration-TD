extends PathFollow2D

var dead = false
var speed : float = 150
var hitpoints = 10
var value = 7


func _physics_process(delta):
	creep_move(delta)
	
	if unit_offset >= 1:
		if not dead:
			dead = true
			get_tree().call_group("Game", "lose_live")
			get_tree().call_group("Spawner", "creep_dead")
			queue_free()


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

