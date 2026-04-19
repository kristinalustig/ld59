extends Control

func _ready() -> void:
	if GameState.archive_docs_discovered.size() == 0:
		#start a new game
		add_doc(1)
	else:
		for e in GameState.archive_docs_discovered:
			add_doc(e)
		
func add_doc(archive_id: int) -> void:
	var doc_scene = load("res://archive/doc_" + str(archive_id) + ".tscn")
	var doc = doc_scene.instantiate()
	$Panel/ArchiveList.add_item(doc.archive_title)
	$Panel/ArchiveList.set_item_metadata($Panel/ArchiveList.item_count-1, doc)

func _on_archive_list_item_selected(index: int) -> void:
	for child in $Panel/ArchiveContent.get_children():
		child.queue_free()
	var archive_data = $Panel/ArchiveList.get_item_metadata(index)
	$Panel/ArchiveContent.add_child(archive_data)


func _on_close_pressed() -> void:
	visible = false
	GameData.window_toggled.emit()


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move_to_front()
