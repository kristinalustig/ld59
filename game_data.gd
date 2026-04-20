extends Node

var symbol_data = {}
var symbol_sprites = preload("res://symbols_sheet.png")

var icon_sprites = preload("res://icons.png")

#load in sfx
var sfx_email = preload("res://sfx/email.wav")
var sfx_pickup_all = preload("res://sfx/pickup_all.wav")
var sfx_success = preload("res://sfx/success.wav")
var sfx_symbol_down = preload("res://sfx/symbol_down.wav")
var sfx_symbol_up = preload("res://sfx/symbol_up.wav")

var s_email
var s_pickup
var s_sym_down
var s_sym_up

var archive_items = []

signal word_clicked(word: String)
signal symbol_clicked(symbol: String)
signal guess_made()
signal window_toggled()
signal advance_made()
signal new_email()
signal add_archive(archive: int)

func _ready():
	get_symbol_data_from_file()
	s_email = AudioStreamPlayer.new()
	s_email.stream = sfx_email
	s_pickup = AudioStreamPlayer.new()
	s_pickup.stream = sfx_pickup_all
	s_sym_down = AudioStreamPlayer.new()
	s_sym_down.stream = sfx_symbol_down
	s_sym_up = AudioStreamPlayer.new()
	s_sym_up.stream = sfx_symbol_up
	
	

func get_email_text_from_file(path_name: String) -> String:
	var file = FileAccess.open("res://emails/email_bodies/" + path_name + ".txt", FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	return text
	
func get_symbol_data_from_file():
	var file = FileAccess.open("res://symbol_data.json", FileAccess.READ)
	symbol_data = JSON.parse_string(file.get_as_text())
	file.close()
