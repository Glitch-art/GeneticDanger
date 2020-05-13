extends KinematicBody2D

export (float) var velocidad
var pos_objetivo = Vector2()
var navegacion = Navigation2D
var path

func _ready():
	set_physics_process(true)
	navegacion = get_tree().get_nodes_in_group("Navegacion")[0]
	pos_objetivo = get_tree().get_nodes_in_group("objetivo")[0]
	

func _physics_process(delta):
	pass
