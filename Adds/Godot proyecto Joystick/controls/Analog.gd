extends Node2D

# Se puede controlar el escalado del joystick usando esta variable.
export var SCALE = 1

# Parametros de salida
var IsTouched = false # Boleano, si estas tocandolo o no.
var Angle = 0 # El angulo (En grados) entre el centro del joystick y el botón
var Strength = 0 # Que tan fuerte se esta presionando, valor(0-1)

var Radius = 70
var MousePos = Vector2()
var MobileMode = false
var TouchPos = Vector2()
var InIndex = -1

func _ready():
	Radius = Radius * SCALE
	$Radius.scale = Vector2(SCALE,SCALE)
	$Button.scale = Vector2(SCALE,SCALE)

func _input(event):
	if event is InputEventMouseButton :
		if event.is_pressed():
			if global_position.distance_to(MousePos)<Radius:
				IsTouched = true
			else:
				IsTouched = false
		else:
			IsTouched = false
	elif event is InputEventScreenTouch:
		var TouchPosTmp = get_canvas_transform().xform_inv(event.position)
		if event.is_pressed():
			if global_position.distance_to(TouchPosTmp)<Radius:
				IsTouched = true
				MobileMode = true
				if(InIndex == -1):
					InIndex = event.index
	elif event is InputEventScreenDrag:
			if(InIndex==event.index):
				TouchPos = get_canvas_transform().xform_inv(event.position)

func _process(delta):
	MousePos=get_global_mouse_position()
	
	if IsTouched == false:
		$Button.position = Vector2(0,0)
		InIndex = -1
	else:
		Angle = 90-rad2deg(MousePos.angle_to_point(position))
		if(MobileMode):
			Angle = 90-rad2deg(TouchPos.angle_to_point(position))
		
		if global_position.distance_to(MousePos)<Radius and MobileMode==false:
			$Button.global_position = MousePos
		elif global_position.distance_to(TouchPos)<Radius and MobileMode==true:
			$Button.global_position = TouchPos
		else:
			
			var Offside = Vector2(sin(deg2rad(Angle)),cos(deg2rad(Angle)))*Radius
			$Button.global_position = global_position+Offside
			pass
	Strength = position.distance_to($Button.global_position)/Radius
	
	$Label.text=str(" TouchPos"+str(TouchPos)+"\n MousePos"+str(MousePos)+"\n Strength : "+str(Strength)+"\n Angle : "+str(Angle) +"\n IsTouched : "+str(IsTouched))
	
func get_joystick(parametro):
	var value = {
		"IsTouched" : IsTouched,
		"Angle" : Angle,
		"Strength" : Strength
	}
	return value[parametro]
