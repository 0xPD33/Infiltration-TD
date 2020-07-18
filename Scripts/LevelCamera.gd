extends Camera2D


func _ready():
	add_to_group("LevelCamera")


func screen_shake():
	$ScreenShake.start(0.1, 12, 8, 0)

