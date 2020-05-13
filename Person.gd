extends KinematicBody2D


func _ready():
	position.x += 23
	pass


func _on_AreaPerson_area_entered(area):
	
	pass # Replace with function body.

#Godot: Colisión con Área de un Objeto (On Area Object-Body Enter)


func _on_Timer_timeout():
	var izquierda = true
	if izquierda:
		position.x -= 100
	else:
		position.x += 100
	pass # Replace with function body.
