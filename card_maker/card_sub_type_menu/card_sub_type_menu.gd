extends VBoxContainer

var card_sub_type : CardSubType


func open_with_sub_type(given_card_sub_type : CardSubType) -> void:
	visible = true
	card_sub_type = given_card_sub_type
	_update_menu_name()
	%CardSubTypeNameBox.text = card_sub_type.name
	%CardBackground.texture = card_sub_type.card_front_texture
	%CardNodeMenu.setup(card_sub_type)


func close() -> void:
	visible = false
	%CardNodeMenu.close()


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


func _on_new_front_texture_button_pressed() -> void:
	%FileDialog.popup_centered_clamped()

func _on_file_dialog_file_selected(path: String) -> void:
	if not visible:
		return
	
	var new_texture: Texture2D= GlobalVariables.load_texture_from_path(path)
	card_sub_type.card_front_texture = new_texture
	%CardBackground.texture = new_texture
