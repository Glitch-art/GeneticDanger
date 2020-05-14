extends KinematicBody2D

#var velocidad = 150
#var path = []
#var navegacion = get_parent().get_parent().get_node("Navegacion")
#
#func _physics_process(delta):
#	var distancia = velocidad * delta
#	path = navegacion._posicion(position)
#	_seguir_ruta(path,distancia)
#
#func _seguir_ruta(enemy,distancia):
#	var ultima_pos = enemy.position
## warning-ignore:unused_variable
#	for i in range(path.size()):
#		var distancia_al_final = ultima_pos.distance_to(path[0])
#		if distancia <= distancia_al_final:
#			enemy.position = ultima_pos.linear_interpolate(path[0],distancia/distancia_al_final)
#			break
#		elif distancia <= 0.0:
#			enemy.position = path[0]
#			break
#		distancia -= distancia_al_final
#		ultima_pos = path[0]
#		path.remove(0)

func _ready():
	pass # Replace with function body.
