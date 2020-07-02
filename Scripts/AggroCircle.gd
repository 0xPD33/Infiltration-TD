extends Node2D

var circle
var circle_pos
var circle_radius
var circle_color


func _ready():
	add_to_group("AggroCircle")


func _draw():
	draw_circle(circle_pos, circle_radius, circle_color)


func draw_aggro_range(pos, radius, color):
	circle_pos = pos
	circle_radius = radius
	circle_color = color
	
	show()


func hide_aggro_range():
	queue_free()

