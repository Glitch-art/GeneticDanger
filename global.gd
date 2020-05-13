extends Node

var salud = 0
var puntos = 0
var tiempo = 0

func _ready():
	salud = 100
	pass
	
	
func update_life():
	get_tree().get_nodes_in_group("LifeLabel")[0].text = str(salud)
	get_tree().get_nodes_in_group("LifeBar")[0].value = salud
	pass
	
func update_score():
	get_tree().get_nodes_in_group("Score")[0].text = puntos
	pass
	
func update_time():
	get_tree().get_nodes_in_group("Time")[0].text = str(tiempo)
	pass
	
