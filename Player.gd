extends KinematicBody2D

var MAX_SPEED = 500
var ACCELERATION = 2000
var motion = Vector2()
var atackUpLoad = load("res://Arma/AtackUp.tscn")
var atackUpInstance
var atackDownLoad = load("res://Arma/AtackDown.tscn")
var atackDownInstance
var atackLeftLoad = load("res://Arma/AtackLeft.tscn")
var atackLeftInstance
var is_atack = false
var atack_up = false
var atack_down = false
var atack_left = false


func _physics_process(delta):
	_atack()
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

# Atacke
func _atack():
	if(Input.is_action_pressed("shoot_up") && !is_atack):
		atackUpInstance = atackUpLoad.instance()
		add_child(atackUpInstance)
		is_atack = true
		$Img.animation = "Atack_Up"
		$Img.frame = 0
		atack_up = true
	
	if(Input.is_action_pressed("shoot_down") && !is_atack):
		atackDownInstance = atackDownLoad.instance()
		add_child(atackDownInstance)
		is_atack = true
		$Img.animation = "Atack_Down"
		$Img.frame = 0
		atack_down = true
	
	if(Input.is_action_pressed("shoot_left") && !is_atack):
		$Img.flip_h = false
		atackLeftInstance = atackLeftLoad.instance()
		atackLeftInstance.set_direction($Img.flip_h)
		add_child(atackLeftInstance)
		is_atack = true
		$Img.animation = "Atack_Left"
		$Img.frame = 0
		atack_left = true
	
	if(Input.is_action_pressed("shoot_right") && !is_atack):
		$Img.flip_h = true
		atackLeftInstance = atackLeftLoad.instance()
		atackLeftInstance.set_direction($Img.flip_h)
		add_child(atackLeftInstance)
		is_atack = true
		$Img.animation = "Atack_Left"
		$Img.frame = 0
		atack_left = true

# Movimiento
func get_input_axis():
	var axis = Vector2.ZERO
	#axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	#axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if(Input.is_action_pressed("ui_right") && !is_atack):
		axis.x = 1
		$Img.flip_h = true
		$Img.animation = "Left"
	if(Input.is_action_pressed("ui_left") && !is_atack):
		axis.x = -1
		$Img.flip_h = false
		$Img.animation = "Left"
	
	if(Input.is_action_pressed("ui_down") && !is_atack):
		axis.y = 1
		$Img.animation = "Down"
	if(Input.is_action_pressed("ui_up") && !is_atack):
		axis.y = -1
		$Img.animation = "Up"
		
	if(axis.length() > 0):
		$Img.play()
		axis.normalized()
#	else:
#		$Img.stop()
	return axis.normalized()
	

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)







func _on_Img_animation_finished():
	if(is_atack):
		if(atack_up):
			atackUpInstance.finish()
			atack_up = false
		if(atack_down):
			atackDownInstance.finish()
			atack_down = false
		if(atack_left):
			atackLeftInstance.finish()
			atack_left = false
		is_atack = false
