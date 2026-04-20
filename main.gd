extends Node2D

var email_icon_up
var email_icon_down

func _ready() -> void:

	
	#load in saved data via game_data from json
	GameData.window_toggled.connect(_on_window_toggled)
	GameData.new_email.connect(_on_new_email)
	
	email_icon_up = AtlasTexture.new()
	email_icon_up.atlas = GameData.icon_sprites
	email_icon_up.region = Rect2(0, 256, 128, 128)
	
	email_icon_down = AtlasTexture.new()
	email_icon_down.atlas = GameData.icon_sprites
	email_icon_down.region = Rect2(0, 0, 128, 128)
	await get_tree().create_timer(3.0).timeout
	$Splash/Title.visible=false
	$Splash/ColorRect.visible = false
	
	

func _on_window_toggled():
	if not $UITop/Email.visible:
		$UIMiddle/HotbarIcons/EmailSm.button_pressed = false
		
	if not $UITop/Notes.visible:
		$UIMiddle/HotbarIcons/NotesSm.button_pressed = false
		
	if not $UITop/Dictionary.visible:
		$UIMiddle/HotbarIcons/DictionarySm.button_pressed = false
		
	if not $UITop/Archives.visible:
		$UIMiddle/HotbarIcons/ArchivesSm.button_pressed = false
		

func _on_new_email():
	$UIMiddle/DesktopIcons/Email.icon = email_icon_up
	$UIMiddle/HotbarIcons/EmailSm.icon = email_icon_up

func _on_email_sm_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$UIMiddle/DesktopIcons/Email.icon = email_icon_down
		$UIMiddle/HotbarIcons/EmailSm.icon = email_icon_down
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
	$UIMiddle/DesktopIcons/Email.icon = email_icon_down
	$UIMiddle/HotbarIcons/EmailSm.icon = email_icon_down
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


func _on_save_sm_pressed() -> void:
	$UIMiddle/HotbarIcons/SaveMsg.visible = true
	await get_tree().create_timer(1.0).timeout
	$UIMiddle/HotbarIcons/SaveMsg.visible = false
	#GameState.save_game()
