extends Control

var current_email_text: String
var mail_icon_texture = preload("res://icons.png")
var mail_icon

func _ready() -> void:
	
	GameData.advance_made.connect(_on_advance_made)
	
	mail_icon = AtlasTexture.new()
	mail_icon.atlas = mail_icon_texture
	mail_icon.region = Rect2(128, 0, 128, 128)
	
	if GameState.emails_received.size() == 0:
		#start a new game
		await get_tree().create_timer(4.0).timeout
		send_email(1)
		#send_email(2)
		#send_email(3)
	else:
		for e in GameState.emails_received:
			send_email(e)

func _on_advance_made():
	if GameState.emails_received.size() >= 2:
		return
	send_email(GameState.emails_received.size()+1)
	if GameState.emails_received.size() == 2:
		send_email(3)
	
func send_email(email_id: int) -> void:
	var email = load("res://emails/email_" + str(email_id) + ".tres")
	var email_body = GameData.get_email_text_from_file("email_" + str(email_id) + "")
	email.email_body = email_body
	$Panel/EmailList.add_item(email.subject_line + " -- " + email.sender_id, mail_icon)
	$Panel/EmailList.set_item_metadata($Panel/EmailList.item_count-1, email)
	GameState.emails_received.append(email)
	GameData.new_email.emit()
	add_child(GameData.s_email)
	GameData.s_email.play()
	if email_id == 1:
		GameData.add_archive.emit(1)
		GameData.add_archive.emit(2)
		GameData.add_archive.emit(3)
	if email_id == 2:
		await get_tree().create_timer(10.0).timeout
		GameData.add_archive.emit(4)
		GameState.the_rest_of_them(GameData.symbol_data)
	

func _on_email_list_item_selected(index: int) -> void:
	var email_data = $Panel/EmailList.get_item_metadata(index)
	$EmailContent/RichTextLabel.text = "Sender: "+email_data.sender_id+"\n"+"Subject: "+email_data.subject_line+"\n\n"+ email_data.email_body
	$EmailContent/RichTextLabel.scroll_to_line(0)


func _on_rich_text_label_meta_clicked(word: Variant) -> void:
	GameState.words_discovered.append(word)
	var regex = RegEx.new()
	regex.compile("\\[url=\"" + word + "\"\\]([^\\[]*)\\[/url\\]")
	var match = regex.search($EmailContent/RichTextLabel.text)
	if match:
		var result = regex.sub($EmailContent/RichTextLabel.text, match.get_string(1))
		$EmailContent/RichTextLabel.text = result
	GameData.word_clicked.emit(word)


func _on_close_pressed() -> void:
	visible = false
	GameData.window_toggled.emit()


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move_to_front()
