extends Control

func _ready() -> void:
	GameData.add_archive.connect(_on_add_archive)
	if GameState.archive_docs_discovered.size() != 0:
		for e in GameState.archive_docs_discovered:
			add_doc(e)
		
func add_doc(archive_id: int) -> void:
	var doc_scene = load("res://archive/doc_" + str(archive_id) + ".tscn")
	var doc = doc_scene.instantiate()
	$Panel/ArchiveList.add_item(doc.archive_title)
	$Panel/ArchiveList.set_item_metadata($Panel/ArchiveList.item_count-1, doc)
	GameState.archive_docs_discovered.append(archive_id)

func _on_archive_list_item_selected(index: int) -> void:
	var found = false
	for child in $Panel/ArchiveContent.get_children():
		if child.archive_id == index+1:
			found = true
			child.visible = true
		else:
			child.visible = false 
	if not found:
		var archive_data = $Panel/ArchiveList.get_item_metadata(index)
		$Panel/ArchiveContent.add_child(archive_data)

func _on_add_archive(num: int):
	add_doc(num)

func _on_close_pressed() -> void:
	visible = false
	GameData.window_toggled.emit()


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move_to_front()
