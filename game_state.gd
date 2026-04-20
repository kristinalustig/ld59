extends Node

#what do we need to track for a save?
var start_from_save = false

var emails_received = []
var solved_entries = []
var dictionary_state = {}
var symbols_discovered = []
var archive_docs_discovered = []
var words_discovered = []
var note_contents = ""

func _ready():
	GameState.check_for_save()

func check_for_save() -> bool:
	var does_save_exist = FileAccess.file_exists("user://save.json")
	if does_save_exist:
		var save = FileAccess.open("user://save.json", FileAccess.READ)
		var save_data = JSON.parse_string(save.get_as_text())
		emails_received = save_data.emails_received
		solved_entries = save_data.solved_entries
		dictionary_state = save_data.dictionary_state
		symbols_discovered = save_data.symbols_discovered
		archive_docs_discovered = save_data.archive_docs_discovered
		words_discovered = save_data.words_discovered
		note_contents = save_data.note_contents
		save.close()
		start_from_save = true
		return true
	return false
	
func save_game() -> void:
	var save_data = {
		"emails_received": emails_received,
		"solved_entries": solved_entries,
		"dictionary_state": dictionary_state,
		"symbols_discovered": symbols_discovered,
		"archive_docs_discovered": archive_docs_discovered,
		"words_discovered": words_discovered,
		"note_contents": note_contents
	}
	var save_data_json = JSON.stringify(save_data)
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(save_data_json)
	file.close()
	
func the_rest_of_them(symbols):
	var index = 0
	for i in symbols:
		if index >= 27:
			print (i)
		index+=1
		GameState.symbols_discovered.append(i)
		GameData.symbol_clicked.emit(i)
