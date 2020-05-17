extends KinematicBody2D

onready var GUI = get_tree().get_nodes_in_group("GUI")[0]
var izquierda = true

func _ready():
	position.x += 23
	pass

func _on_Timer_timeout():
	if izquierda:
		position.x -= 100
		izquierda = false
	else:
		position.x += 100
		izquierda = true
	pass # Replace with function body.

func _on_AreaPerson_body_entered(body):
	
	pass # Replace with function body.

func _on_AreaPerson_area_entered(area):
	if area.get_name() == "AreaPlayer":
		GUI.llevaPersona = true
		GUI.update_imagePerson()
		get_tree().get_nodes_in_group("Navigation_group")[0].buscarCasa()
		queue_free()
	pass # Replace with function body.
