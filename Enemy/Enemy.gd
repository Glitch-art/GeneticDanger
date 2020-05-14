extends KinematicBody2D

var axis
var player = load("res://Player.tscn")
var player_instance
var player_posicion
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

func _physics_process(delta):
	axis = position
	player_instance = player.instance()
	player_posicion = player_instance.position
	animacion()
	death()
#	if(get_slide_collision(get_slide_count()-1) != null):
#		var obj_col = get_slide_collision(get_slide_count()-1).collider
#		if(obj_col.get_tree().get_nodes_in_group("Atack_Down")[0]):
#			queue_free()

func animacion():
	if(axis.x < player_posicion.x ):
		$AnimacionEnemy.flip_h = false
		$AnimacionEnemy.animation = "Run"
	if(axis.x > player_posicion.x):
		$AnimacionEnemy.flip_h = true
		$AnimacionEnemy.animation = "Run"
	if(axis.length() > 0):
		$AnimacionEnemy.play()
		axis.normalized()
	return axis.normalized()

func death():
	pass




func _on_AreaEnemy_area_entered(area):
	if(area.get_name() == "AtackDown"):
		queue_free()
