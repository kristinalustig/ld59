extends Control

var current_email_text: String
var mail_icon_texture = preload("res://icons.png")
var mail_icon


func _ready() -> void:
	
	mail_icon = AtlasTexture.new()
	mail_icon.atlas = mail_icon_texture
	mail_icon.region = Rect2(128, 0, 128, 128)
	
	if GameState.emails_received.size() == 0:
		#start a new game
		send_email(1)
	else:
		for e in GameState.emails_received:
			send_email(e)
		
	
func send_email(email_id: int) -> void:
	var email = load("res://emails/email_" + str(email_id) + ".tres")
	var email_body = GameData.get_email_text_from_file("email_" + str(email_id) + "")
	email.email_body = email_body
	$Panel/EmailList.add_item(email.subject_line + " -- " + email.sender_id, mail_icon)
	$Panel/EmailList.set_item_metadata($Panel/EmailList.item_count-1, email)
	

func _on_email_list_item_selected(index: int) -> void:
	var email_data = $Panel/EmailList.get_item_metadata(index)
	$EmailContent/RichTextLabel.text = "Sender: "+email_data.sender_id+"\n"+"Subject: "+email_data.subject_line+"\n\n"+ email_data.email_body


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
