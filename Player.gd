extends KinematicBody2D

var MAX_SPEED = 500
var ACCELERATION = 2000
var motion = Vector2()
	
func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
	
	
	#Interactuar colisionando con objetos
	if get_slide_collision(get_slide_count() -1) != null:
		var obj_colisionado = get_slide_collision(get_slide_count() -1).collider
		if obj_colisionado.is_in_group("Bottle_group"):
			# Proceso
			obj_colisionado.get_node("Sprite_Bottle").frame_coords = Vector2(0,9)
	
	#Muerte por oprimir M   (Temporal)...
	if Input.is_action_just_pressed("Tecla_Morir"):
		get_tree().get_nodes_in_group("World")[0].death() # Funcion death (Morir)

# Movimiento
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if(axis.x > 0):
		$Img.flip_h = true
		$Img.animation = "Left"
	
	if(axis.x < 0):
		$Img.flip_h = false
		$Img.animation = "Left"
	
	if(axis.length() > 0):
		$Img.play()
		axis.normalized()
	
	if(axis.y > 0):
		$Img.animation = "Down"
	
	if(axis.y < 0):
		$Img.animation = "Up"
	
	if(axis.length() > 0):
		$Img.play()
		axis.normalized()
	else:
		$Img.stop()
	return axis.normalized()
	

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)





