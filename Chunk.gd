extends Area2D

var rng = RandomNumberGenerator.new()

export (PackedScene) var Enemy

func _ready():
	pass

func _on_TimerChunk_timeout():
	var num = 10 #dificultad = 4
#	yield(get_tree().create_timer(5.0), "timeout")
	print ("Dificultad = " + str(num))
	_random_Enemies(num)
	print ("------------------------------------------")
	pass
	
func _activate_Spawns_Enemies(numEnemigos:int):
	for i in range(numEnemigos+1):
		if i > 0:
			createEnemy(str(i))

func _random_Enemies(difficulty): # dificultad (0-10)
	rng.randomize()
	var rangoFinal = (difficulty*0.24)+1	# (1-3.4)
	#Probabilidad de espawneo es de 0 a 3 enemigos
	var numRandom = rng.randi_range(0,rangoFinal) 
	print ("Numero de enemigos spawneados = " + str(numRandom))
	if numRandom > 0:
		_activate_Spawns_Enemies(numRandom)
	pass


func createEnemy(numSpawn:String):
	#instanciar el nuevo enemigo
	var newEnemy = Enemy.instance()
	# Obtener nodos en el grupo "World"  ...  Añadirle al grupo "World" el newEnemigo
	get_tree().get_nodes_in_group("World")[0].add_child(newEnemy)
	#Establecer posicion
	newEnemy.global_position = get_node("Shape/SpawnEnemy" + numSpawn).global_position
	
func createPerson():
	pass

#func 
#
#const numChunks = 16
#
#señal persona recogida:
#	chunkSeleccionado = 0-15
#	while (chunkSeleccionado != ChunkconPersona)
#		Buscar otro chunk aleatorio
#	poner persona en = chunkSeleccionado.position

