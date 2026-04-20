extends Control

var dict_item = preload("res://dict_item.tscn")
var item = preload("res://item.tscn")

func _ready():
	GameData.word_clicked.connect(_on_word_clicked)
	GameData.symbol_clicked.connect(_on_symbol_clicked)
	GameData.guess_made.connect(_on_guess_made)
	
	#load in all the words from the json file that could possibly be "solved"
	if not GameState.start_from_save:
		var keys = GameData.symbol_data.keys()
		keys.sort()
		for key in keys:
			var display_word = key if GameState.words_discovered.has(key) else "???"
			GameState.dictionary_state[key] = {"symbol_id":"", "display_word": display_word, "word": key}
	else:
		#if we already have a save we want to preserve symbol order so we don't show our hand		
		for s in GameState.symbols_discovered:
			var is_placed = false
			for row in GameState.dictionary_state.values():
				if row["symbol_id"] == s:
					is_placed = true
					break
			if not is_placed:
				var symbol = item.instantiate()
				symbol.on_creation(s, GameData.symbol_data[s]["spritesheet_index"])
				$ScrollContainer2/SymbolBox.add_child(symbol)
	
	#in any case, we want to actually add each dictionary line in
	for i in GameState.dictionary_state:
		var new_line = dict_item.instantiate()
		if GameState.dictionary_state[i]["symbol_id"] != "":
			var symbol = item.instantiate()
			symbol.on_creation(GameState.dictionary_state[i]["symbol_id"], GameData.symbol_data[i["symbol_id"]]["spritesheet_index"])
			new_line.get_node("Symbol").add_child(symbol)
		new_line.get_node("Word").text = GameState.dictionary_state[i]["display_word"]
		$ScrollContainer/ActiveDict.add_child(new_line)
		
func _on_word_clicked(word: String):
	update_dict_state(word)

func _on_symbol_clicked(symbol: String):
	if GameState.symbols_discovered.has(symbol):
		var symbol_item = item.instantiate()
		symbol_item.on_creation(symbol, GameData.symbol_data[symbol]["spritesheet_index"])
		$ScrollContainer2/SymbolBox.add_child(symbol_item)
	
func update_dict_state(word: String):
	if GameState.words_discovered.has(word):
		var index = 0
		for i in GameState.dictionary_state:
			if GameState.dictionary_state[i]["word"] == word:
				GameState.dictionary_state[i]["display_word"] = word
				var line = $ScrollContainer/ActiveDict.get_child(index)
				line.get_node("Word").text = word
				return
			index += 1
				
func _on_guess_made():
	var numCorrect = 0
	for i in GameState.dictionary_state:
		if GameState.dictionary_state[i]["symbol_id"] == GameState.dictionary_state[i]["display_word"]:
			numCorrect += 1
	
	if numCorrect - GameState.solved_entries.size() >= 5:
		var index = 0
		for i in GameState.dictionary_state:
			if GameState.dictionary_state[i]["symbol_id"] == GameState.dictionary_state[i]["display_word"]:
				make_permanent(i, index)
			index += 1
		GameData.advance_made.emit()
		
		
func make_permanent(i: String, index: int):
	var line = $ScrollContainer/ActiveDict.get_child(index)
	var style = StyleBoxEmpty.new()
	line.get_node("Symbol").add_theme_stylebox_override("panel", style)
	line.get_node("Symbol").mouse_filter = Control.MOUSE_FILTER_IGNORE
	print(line.get_child(2).name)
	line.get_child(2).mouse_filter = Control.MOUSE_FILTER_IGNORE
	GameState.solved_entries.append(i)

func _on_close_pressed() -> void:
	visible = false
	GameData.window_toggled.emit()


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move_to_front()
