extends KinematicBody2D

onready var GUI = get_tree().get_nodes_in_group("GUI")[0]
export (PackedScene) var attackUpLoad
var attackUpInstance
export (PackedScene) var attackDownLoad
var attackDownInstance
export (PackedScene) var attackLeftLoad
var attackLeftInstance

var MAX_SPEED = 500
var ACCELERATION = 2000
var motion = Vector2()

var is_attack = false
var attack_up = false
var attack_down = false
var attack_left = false
var time = false

func _ready():
	pass

func _physics_process(delta):
	_attack()
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
func _attack():
	if(Input.is_action_pressed("shoot_up") && !is_attack):
		attackUpInstance = attackUpLoad.instance()
		add_child(attackUpInstance)
		is_attack = true
		$Img.animation = "Attack_Up"
		$Img.frame = 0
		attack_up = true
	
	if(Input.is_action_pressed("shoot_down") && !is_attack):
		attackDownInstance = attackDownLoad.instance()
		add_child(attackDownInstance)
		is_attack = true
		$Img.animation = "Attack_Down"
		$Img.frame = 0
		attack_down = true
	
	if(Input.is_action_pressed("shoot_left") && !is_attack):
		$Img.flip_h = false
		attackLeftInstance = attackLeftLoad.instance()
		attackLeftInstance.set_direction($Img.flip_h)
		add_child(attackLeftInstance)
		is_attack = true
		$Img.animation = "Attack_Left"
		$Img.frame = 0
		attack_left = true
	
	if(Input.is_action_pressed("shoot_right") && !is_attack):
		$Img.flip_h = true
		attackLeftInstance = attackLeftLoad.instance()
		attackLeftInstance.set_direction($Img.flip_h)
		add_child(attackLeftInstance)
		is_attack = true
		$Img.animation = "Attack_Left"
		$Img.frame = 0
		attack_left = true

# Movimiento
func get_input_axis():
	var axis = Vector2.ZERO
	#axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	#axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if(Input.is_action_pressed("ui_right") && !is_attack):
		axis.x = 1
		$Img.flip_h = true
		$Img.animation = "Left"
	if(Input.is_action_pressed("ui_left") && !is_attack):
		axis.x = -1
		$Img.flip_h = false
		$Img.animation = "Left"
	if(Input.is_action_pressed("ui_down") && !is_attack):
		axis.y = 1
		$Img.animation = "Down"
	if(Input.is_action_pressed("ui_up") && !is_attack):
		axis.y = -1
		$Img.animation = "Up"
	if(axis.length() == 0 && !is_attack):
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

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)


func _on_Img_animation_finished():
	if(is_attack):
		if(attack_up):
			attackUpInstance.finish()
			attack_up = false
		if(attack_down):
			attackDownInstance.finish()
			attack_down = false
		if(attack_left):
			attackLeftInstance.finish()
			attack_left = false
		is_attack = false


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
	pass # Replace with function body.
