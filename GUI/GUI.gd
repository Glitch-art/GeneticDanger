extends CanvasLayer

func _ready():
	pass

func _on_Timer_timeout():
	Global.tiempo +=1
	Global.update_time()
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
