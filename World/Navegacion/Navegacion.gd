extends Navigation2D

var velocidad = 200
var path = []

func _physics_process(delta):
	if(get_tree().get_nodes_in_group("Player_group")[0]):
		var distancia = velocidad * delta
		_seguir_ruta(distancia)
		_posicion()

func _posicion():
		_nueva_ruta($Enemy.position,get_tree().get_nodes_in_group("Player_group")[0].position)

func _nueva_ruta(pos_inicial,pos_final):
	path = self.get_simple_path(pos_inicial,pos_final,true)
	path.remove(0)

func _seguir_ruta(distancia):
	var ultima_pos = $Enemy.position
	for i in range(path.size()):
		var distancia_al_final = ultima_pos.distance_to(path[0])
		if distancia <= distancia_al_final:
			$Enemy.position = ultima_pos.linear_interpolate(path[0],distancia/distancia_al_final)
			break
		elif distancia <= 0.0:
			$Enemy.position = path[0]
			break
		distancia -= distancia_al_final
		ultima_pos = path[0]
		path.remove(0)

#var enemigos = get_tree().get_nodes_in_group("Enemy_group")
