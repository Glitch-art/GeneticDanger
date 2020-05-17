extends Node

export (PackedScene) var Navegacion
export (PackedScene) var Player
export (PackedScene) var Person
export (PackedScene) var GUI

func _ready():
	# Añadir GUI
	var newGUI = GUI.instance()
	add_child(newGUI)
	
	# Añadir Navegación
	var newNavegacion = Navegacion.instance()
	add_child(newNavegacion)
	
	# Añadir Jugador
	var newPlayer = Player.instance()
	add_child(newPlayer)
	newPlayer.global_position = get_tree().get_nodes_in_group("SpawnPlayer_group")[0].global_position
	pass

func death():
	# Guardar datos
	Persistence.data["PuntajeMaximo"] = int(get_tree().get_nodes_in_group("GUI")[0].maxPoints)
	Persistence.save_data()
	# Cambiar escena Fin del Juego
	get_tree().change_scene("res://Gameover.tscn")
	pass
