extends KinematicBody2D

var axis
var vidas = 3
var tiempo = false

func _ready():
	pass # Replace with function body.

func death():
	get_tree().get_nodes_in_group("GUI")[0].addPoints(5)
	queue_free()
	pass

func _on_AreaEnemy_area_entered(area):
	if(area.get_name() == "AtackDown" || area.get_name() == "AtackLeft" || area.get_name() == "AtackUp"):
		if(!tiempo):
			if(vidas <= 0):
				death()
			vidas -= 1
			tiempo = true
			yield(get_tree().create_timer(0.0),"timeout")
			tiempo = false
