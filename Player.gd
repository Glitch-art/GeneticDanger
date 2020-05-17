extends KinematicBody2D

onready var GUI = get_tree().get_nodes_in_group("GUI")[0]
export (PackedScene) var atackUpLoad
var atackUpInstance
export (PackedScene) var atackDownLoad
var atackDownInstance
export (PackedScene) var atackLeftLoad
var atackLeftInstance

var MAX_SPEED = 500
var ACCELERATION = 2000
var motion = Vector2()

var is_atack = false
var atack_up = false
var atack_down = false
var atack_left = false
var time = false

func _physics_process(delta):
	_atack()
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
	
	#Muerte por oprimir M   (Temporal)...
	if Input.is_action_just_pressed("Tecla_Morir"):
		get_tree().get_nodes_in_group("World")[0].death() # Funcion death (Morir)

# Ataque
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
	pass

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
	if(axis.length() == 0 && !is_atack):
		$Img.animation = "Down"
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
	pass

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
	pass

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
	pass


func _on_AreaPlayer_area_entered(area):
	if(area.get_name() == "AreaEnemy"):
		if(!time):
			if(GUI.salud <= 0):
				get_tree().get_nodes_in_group("World")[0].death()
			GUI.salud -= 10
			GUI.update_life()
			print("Salud Jugador = " + str(GUI.salud))
			time = true
			yield(get_tree().create_timer(1.0),"timeout")
			time = false
	pass
