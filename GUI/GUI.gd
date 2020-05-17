extends CanvasLayer

var maxPoints = 0
export (int) var salud = 100
export (int) var puntos = 0
export (int) var tiempo = 0
export (int) var dificultad = 0
export (int) var personasEnCasa = 0
#Puntos necesarios para subir de dificultad
export (int) var puntosDificultad = 50 
#El porcentaje con el que va aumentando los puntos necesarios para subir de dificultad
export (int) var porcentajeDificultadAumento = 0.1	# 10%

var llevaPersona = false


func _ready():
	$Message.visible = false
	$PointsAdded.visible = false
	update_life()
	update_score()
	update_time()
	update_imagePerson()
	update_PeopleAtHome()
	pass

func process(delta):
	#Sistema de nivel de dificultad, dependiendo de la puntuación.
	if (puntos > puntosDificultad) and (puntos > 0):
		dificultad += 1
		puntosDificultad += puntosDificultad + (porcentajeDificultadAumento * puntosDificultad)

func update_life():
	$UI/vida/barra/contador/fondo/numero.text = str(salud)
	$UI/vida/barra/medidor.value = salud
	pass

func update_score():
	$Score.text = str(puntos)
	if puntos > maxPoints:
		maxPoints = puntos
	pass

func update_time():
	$Time.text = str(tiempo)
	pass

func update_imagePerson():
	$Persona.visible = llevaPersona
	if ($Persona.visible == false):
		get_tree().get_nodes_in_group("Navigation_group")[0].createFirstPeople()
	pass

func update_PeopleAtHome():
	$PeopleAtHome.text = str(personasEnCasa)
	llevaPersona = false
	personasEnCasa += 1
	update_imagePerson()
	pass

func addPoints(puntosAnadidos:int):
	puntos += puntosAnadidos
	$PointsAdded.text = ("+" + str(puntosAnadidos))
	$PointsAdded.visible = true
	yield(get_tree().create_timer(1.5),"timeout")
	$PointsAdded.visible = false
	pass

func _on_Timer_timeout():
	tiempo +=1
	puntos +=1
	update_score()
	update_time()
	pass



#
#func update_life(cantidad:int):
#	$UI/vida/barra/contador/fondo/numero.text = str(cantidad)
#	$UI/vida/barra/medidor.value = cantidad
#	pass
#
#func update_score(cantidad:int):
#	$Score.text = str(cantidad)
#	pass
