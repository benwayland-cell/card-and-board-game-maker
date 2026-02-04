extends VBoxContainer

var card_sub_type : CardSubType


func open_with_sub_type(given_card_sub_type : CardSubType) -> void:
	visible = true
	card_sub_type = given_card_sub_type
	_update_menu_name()
	%CardSubTypeNameBox.text = card_sub_type.name


func close() -> void:
	visible = false


func _update_menu_name() -> void:
	%MenuName.text = %CardTypeMenu.card_type.name + " / " + card_sub_type.name


func _on_card_sub_type_name_box_text_submitted(new_text: String) -> void:
	# if the text isn't empty
	if new_text != "":
		card_sub_type.name = new_text
		_update_menu_name()
		return
	
	# reset the text if it is empty
	%CardSubTypeNameBox.text = card_sub_type.name


func _on_back_button_pressed() -> void:
	if not visible:
		return
	
	close()
	%CardTypeMenu.open()
