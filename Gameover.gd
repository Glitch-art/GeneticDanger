extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	$Wallpaper.visible = true
	var frases = {
		0:"Al estornudar, cúbrete con la parte interna del codo.",
		1:"Evita el contacto cercano con personas enfermas.",
		2:"Si tienes síntomas de resfriado, quédate en casa y usa tapabocas.",
		3:"Limpia y desinfecta los objetos y las superficies que se tocan frecuentemente.",
		4:"Recuerda usar un antibacterial que tenga un 70% o más de alcohol.",
		5:"Mantente actualizado, infórmate del coronavirus.",
		6:"Recuerda lavar tus prendas de vestir al llegar a casa.",
		7:"Sal en los días designados, sólo si es necesario.",
		}
	rng.randomize()
	var num_random = rng.randi_range(0,frases.size()-1)
	$Etiqueta.set_text(frases[num_random])

func _on_Timer_timeout():
	$Wallpaper.visible = false
	pass # Replace with function body.
