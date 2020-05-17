extends Node

const PATH = "user://data.dat"
const PASS = "contraseña123"

var is_loaded = false

var data = {
	"Nombre" : "",
	"PuntajeMaximo" : 0
}

func _ready():
#	var file = File.new()
#
#	if file.file_exists(PATH):
#		load_data()
#	else:
#		save_data()
#		load_data()
	pass

func save_data():
	var file = File.new()
	
	file.open_encrypted_with_pass(PATH, File.WRITE, PASS)
	file.store_var(data)
	file.close()
	
	is_loaded = false

func load_data():
	if is_loaded:
		return
	
	var file = File.new()
	
	file.open_encrypted_with_pass(PATH, File.READ, PASS)
	data = file.get_var()
	file.close()
	
	is_loaded = true
	
