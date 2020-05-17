extends Area2D

func set_direction(direction):
	if(direction):
		position.x *= -1 


func finish():
	queue_free()
