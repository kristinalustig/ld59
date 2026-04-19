extends Control


func _on_close_pressed() -> void:
	visible = false
	GameData.window_toggled.emit()


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move_to_front()
