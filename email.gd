extends Control

var current_email_text: String

func _ready() -> void:
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
	$Panel/EmailList.add_item(email.subject_line + " -- " + email.sender_id)
	$Panel/EmailList.set_item_metadata($Panel/EmailList.item_count-1, email)
	

func _on_email_list_item_selected(index: int) -> void:
	var email_data = $Panel/EmailList.get_item_metadata(index)
	$EmailContent/RichTextLabel.text = email_data.email_body


func _on_rich_text_label_meta_clicked(word: Variant) -> void:
	GameState.words_discovered.append(word)
	var regex = RegEx.new()
	regex.compile("\\[url=\"" + word + "\"\\]([^\\[]*)\\[/url\\]")
	var match = regex.search($EmailContent/RichTextLabel.text)
	if match:
		var result = regex.sub($EmailContent/RichTextLabel.text, match.get_string(1))
		$EmailContent/RichTextLabel.text = result
