extends TouchScreenButton

func _on_TouchScreenButton_pressed():
	get_tree().change_scene("res://World.tscn")

func _ready():
	get_parent().get_node("maxPoints").text = str(Persistence.data["PuntajeMaximo"])
