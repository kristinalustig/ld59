extends Panel


func _can_drop_data(_position, _data):
	return true
	
func _drop_data(_position, data):
	data.reparent(self.get_parent())
	data.global_position = Vector2(self.global_position.x + 4, self.global_position.y+4)
	for i in GameState.dictionary_state:
		if GameState.dictionary_state[i]["word"] == self.get_parent().get_node("Word").text:
			GameState.dictionary_state[i]["symbol_id"] = data.item_id
			break
	if not self.get_child(1):
		add_child(GameData.s_sym_down)
	GameData.s_sym_down.play()
	GameData.guess_made.emit()
