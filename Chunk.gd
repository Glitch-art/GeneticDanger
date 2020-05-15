extends Area2D

# Un chunk puede generar de 0 a 3 enemigos, y/o una persona.

var rng = RandomNumberGenerator.new()

export (PackedScene) var Enemy
export (PackedScene) var Person
export (int) var difficulty = 4
var numChunks

# Detecta el numero de Chunks existentes
func _ready():
	numChunks = get_tree().get_nodes_in_group("Chunk_group").size()
	print(numChunks)
	pass

# Cada cierto tiempo se activaran los Chunks
func _on_TimerChunk_timeout():
	_random_Enemies(difficulty)

# Genera un numero aleatorio(Numero de enemigos), dependiendo de la dificultad
func _random_Enemies(difficulty:int): # dificultad (0-10)
	rng.randomize()
	var rangoFinal = (difficulty*0.24)+1	# (1-3.4)
	#Probabilidad de espawneo es de 0 a 3 enemigos
	var numRandom = rng.randi_range(0,rangoFinal) 
	if numRandom > 0:
		_activate_Spawns_Enemies(numRandom)
	pass

# Reparte los enemigos por los tres spawnEnemy
func _activate_Spawns_Enemies(numEnemigos:int):
	for i in range(numEnemigos+1):
		if i > 0:
			createEnemy(str(i))

# Crea los enemigos en los Spawn
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

