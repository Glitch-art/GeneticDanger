extends Area2D

var rng = RandomNumberGenerator.new()

export (PackedScene) var Enemy

func _ready():
	for i in range(0,11):
		var num = (int(i))
		print ("Dificultad = " + str(num))
		_activate_Spawns_Enemies(num)
		print ("------------------------------------------")
		pass
	
func _activate_Spawns_Enemies(difficulty): # dificultad (0-10)
	rng.randomize()
	var rangoFinal = (difficulty*0.24)+1	# (1-3.4)
	#Probabilidad de espawneo es de 0 a 3 enemigos
	var numRandom = rng.randi_range(0,rangoFinal) 
	print ("Rango = (0-" + str(rangoFinal) + ")")
	print ("Numero de enemigos spawneados = " + str(numRandom))
	pass


#
#func 
#
#const numChunks = 16
#
#señal persona recogida:
#	chunkSeleccionado = 0-15
#	while (chunkSeleccionado != ChunkconPersona)
#		Buscar otro chunk aleatorio
#	poner persona en = chunkSeleccionado.position

