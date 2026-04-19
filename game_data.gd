extends Node

var symbol_data = []

func _ready():
	pass

func get_email_text_from_file(path_name: String) -> String:
	var file = FileAccess.open("res://emails/email_bodies/" + path_name + ".txt", FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	return text
	
func get_symbol_data_from_file():
	var file = FileAccess.open("res://symbol_data.json", FileAccess.READ)
	symbol_data = JSON.parse_string(file.get_as_text())
	file.close()
	pass
