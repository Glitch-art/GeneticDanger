extends TouchScreenButton

enum state {seleccionar}
var estado = state

func _on_TouchScreenButton_pressed():
	get_tree().change_scene("res://World.tscn")
	estado = state.seleccionar

func _ready():
	get_parent().get_node("Label").text = str(Persistence.data["PuntajeMaximo"])
