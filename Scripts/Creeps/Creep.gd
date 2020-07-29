extends PathFollow2D

var dead = false

var speed : float
var hitpoints : float
var max_hitpoints : float
var value : int

var popup_damage = preload("res://Scenes/PopupDamage.tscn")

var anims_setup = false

var hurt_anim
var walk_anim

signal hurt


func _ready():
	yield(get_tree(), "idle_frame")
	hurt_anim = get_node("CreepHurtAnimation")
	walk_anim = get_node("CreepWalkAnimation")
	anims_setup = true
	
	if Global.healthbar_enabled:
		get_node("HealthBar").set_max_health(max_hitpoints)
		connect("hurt", get_node("HealthBar"), "_on_creep_hurt")
	
	hitpoints = max_hitpoints


func _physics_process(delta):
	creep_move(delta)
	check_unit_offset()


func creep_move(delta):
	offset += speed * delta
	if anims_setup:
		creep_walk_anim()


func check_unit_offset():
	if unit_offset >= 1:
		if not dead:
			dead = true
			get_tree().call_group("Game", "lose_live")
			get_parent().creep_dead()
			queue_free()


func check_hitpoints():
	if hitpoints <= 0:
		dead = true
		get_parent().creep_dead()
		get_tree().call_group("Game", "add_cash", value)
		queue_free()


func creep_walk_anim():
	if Global.animations and hurt_anim.is_playing() == false:
		walk_anim.play("creep_walk")


func creep_hurt_anim():
	if Global.animations:
		hurt_anim.play("creep_hurt")


func create_popup_damage(dmg, color, size):
	if Global.damage_numbers_enabled:
		var popup_instance = popup_damage.instance()
		get_parent().get_parent().add_child(popup_instance)
		popup_instance.modulate = color
		popup_instance.scale = size
		popup_instance.position = get_global_transform().origin
		popup_instance.popup_damage(dmg)


func call_healthbar():
	if Global.healthbar_enabled:
		emit_signal("hurt", hitpoints)


func _on_damage(dmg):
	hitpoints -= dmg
	creep_hurt_anim()
	call_healthbar()
	
	check_hitpoints()


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group("TurretProjectile"):
		_on_damage(area.damage)
		create_popup_damage(area.damage, Color.white, Vector2(1.0, 1.0))
		area.queue_free()
	elif area.is_in_group("BomberProjectile"):
		_on_damage(area.damage)
		create_popup_damage(area.damage, Color.gray, Vector2(1.25, 1.25))
	elif area.is_in_group("SniperProjectile"):
		_on_damage(area.damage)
		create_popup_damage(area.damage, Color.red, Vector2(1.25, 1.25))
		area.queue_free()
	elif area.is_in_group("Explosion"):
		_on_damage(area.damage)
		create_popup_damage(area.damage, Color.darkred, Vector2(1.5, 1.5))

