extends Node2D

func _ready() -> void:
	#load in saved data via game_data from json
	GameState.check_for_save()


func _on_email_sm_toggled(toggled_on: bool) -> void:
	$UITop/Email.visible = toggled_on
	$UITop/Email.move_to_front()

func _on_notes_sm_toggled(toggled_on: bool) -> void:
	$UITop/Notes.visible = toggled_on
	$UITop/Notes.move_to_front()

func _on_dictionary_sm_toggled(toggled_on: bool) -> void:
	$UITop/Dictionary.visible = toggled_on
	$UITop/Dictionary.move_to_front()

func _on_archives_sm_toggled(toggled_on: bool) -> void:
	$UITop/Archives.visible = toggled_on
	$UITop/Archives.move_to_front()

func _on_email_pressed() -> void:
	$UITop/Email.visible = true
	$UIMiddle/HotbarIcons/EmailSm.button_pressed = true
	$UITop/Email.move_to_front()

func _on_notes_pressed() -> void:
	$UITop/Notes.visible = true
	$UIMiddle/HotbarIcons/NotesSm.button_pressed = true
	$UITop/Notes.move_to_front()

func _on_dictionary_pressed() -> void:
	$UITop/Dictionary.visible = true
	$UIMiddle/HotbarIcons/DictionarySm.button_pressed = true
	$UITop/Dictionary.move_to_front()

func _on_archives_pressed() -> void:
	$UITop/Archives.visible = true
	$UIMiddle/HotbarIcons/ArchivesSm.button_pressed = true
	$UITop/Archives.move_to_front()
