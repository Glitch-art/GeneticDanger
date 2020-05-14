extends CanvasLayer

export (int) var salud = 100
export (int) var puntos = 0
export (int) var tiempo = 0
export (bool) var llevaPersona = false

func _ready():
	update_life()
	update_score()
	update_time()
	update_imagePerson()
	pass
	
func process(delta):
	pass
	
func update_life():
	$UI/vida/barra/contador/fondo/numero.text = str(salud)
	$UI/vida/barra/medidor.value = salud
	pass
	
func update_score():
	$Score.text = str(puntos)
	pass
	
func update_time():
	$Time.text = str(tiempo)
	pass

func update_imagePerson():
	$Persona.visible = llevaPersona
	pass


func _on_Timer_timeout():
	tiempo +=1
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
