extends Node

var symbol_data = {}
var symbol_sprites = preload("res://symbols_sheet.png")

var archive_items = []

signal word_clicked(word: String)
signal symbol_clicked(symbol: String)
signal guess_made()
signal window_toggled()
signal advance_made()

func _ready():
	get_symbol_data_from_file()

func get_email_text_from_file(path_name: String) -> String:
	var file = FileAccess.open("res://emails/email_bodies/" + path_name + ".txt", FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	return text
	
func get_symbol_data_from_file():
	var file = FileAccess.open("res://symbol_data.json", FileAccess.READ)
	symbol_data = JSON.parse_string(file.get_as_text())
	file.close()
