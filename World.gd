extends Node

export (PackedScene) var Player
export (PackedScene) var Bottle

func _ready():
	var newPlayer = Player.instance()
	add_child(newPlayer)
	newPlayer.global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	
	# Crear Botella (instanciar la escena Botella.tscn)
	var newBottle = Bottle.instance()
	add_child(newBottle)
	newBottle.global_position = Vector2(928,96)

func death():
	# Opcion 1: Teletrasportar el jugador
#	get_tree().get_nodes_in_group("Player_group")[0].global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	
	# Opcion 2: Eliminar y crear personaje
	# Lo elimina con camara y elementos (TODO)
	get_tree().get_nodes_in_group("Player_group")[0].queue_free()
	var newPlayer = Player.instance()
	add_child(newPlayer)
	newPlayer.global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	

	# Reiniciar Botella
	get_tree().get_nodes_in_group("Bottle_group")[0].queue_free()
	var newBottle = Bottle.instance()
	add_child(newBottle)
	newBottle.global_position = Vector2(928,96)
	
	
	get_tree().change_scene("res://Gameover.tscn")
