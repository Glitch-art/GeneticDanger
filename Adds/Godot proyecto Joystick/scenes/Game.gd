extends Node2D

onready var cam = $Personaje/Camera2D
onready var person = $Personaje
onready var joystick = $Joystick 
var length_between_camera_joystick = Vector2(336,-176)
var inicio
func _process(delta):
	if inicio == true:
		#length_between_camera_joystick = cam.get_camera_position()-joystick.get_position()
		inicio = false
	
	joystick.set_position(cam.global_position - length_between_camera_joystick)
	print(cam.global_position)
	pass
