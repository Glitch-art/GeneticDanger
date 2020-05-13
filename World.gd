extends Node

export (PackedScene) var Player
export (PackedScene) var Person
export (PackedScene) var GUI

func _ready():
	var newPlayer = Player.instance()
	add_child(newPlayer)
	newPlayer.global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	
	# Añadir GUI
	var newGUI = GUI.instance()
	add_child(newGUI)
	
	
	# Crear Person (instanciar la escena Person.tscn)
	var newPerson = Person.instance()
	add_child(newPerson)
	newPerson.global_position = Vector2(1090,96)
	

func death():
	# Opcion 1: Teletrasportar el jugador
#	get_tree().get_nodes_in_group("Player_group")[0].global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	
	# Opcion 2: Eliminar y crear personaje
	# Lo elimina con camara y elementos (TODO)
	get_tree().get_nodes_in_group("Player_group")[0].queue_free()
	
	#Y lo añade de nuevo
	var newPlayer = Player.instance()
	add_child(newPlayer)
	newPlayer.global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	

	# Reiniciar Person
	get_tree().get_nodes_in_group("Person_group")[0].queue_free()
	var newPerson = Person.instance()
	add_child(newPerson)
	newPerson.global_position = Vector2(1090,96)
	
	#Matar Enemigos
	var enemigos = get_tree().get_nodes_in_group("Enemy_group")
	if enemigos:
		for i in range(enemigos.size()):
			enemigos[i].queue_free()
	#Pausar Spawn de enemigos
	$SpawnEnemy/Timer.set_paused(true)
	
	
	
# warning-ignore:return_value_discarded
	#get_tree().change_scene("res://Gameover.tscn")
var puntos = 2
var vidas = []

func update_puntos():
	#get_tree().get_nodes_in_group("puntos")[0].text = String(Puntos)
	pass

func update_vida():
#	var newVida = vida.instance()
#	$GUI.add_child(newVida)
#	newVida.global_position += Vector2(offset*a,0)
	pass




