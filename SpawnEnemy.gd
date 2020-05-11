extends Position2D

export (PackedScene) var Enemy

func _ready():
	pass


func _on_Timer_timeout():
	#instanciar el nuevo enemigo
	var newEnemy = Enemy.instance()
	# Obtener nodos en el grupo "World"  ...  Añadirle al grupo "World" el newEnemigo
	get_tree().get_nodes_in_group("World")[0].add_child(newEnemy)
	#Establecer posicion
	newEnemy.global_position = global_position
