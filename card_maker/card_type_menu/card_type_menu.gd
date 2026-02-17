extends VBoxContainer

var card_type: CardType


# opens the menu with the data of a card type
func open_card_type(given_card_type : CardType) -> void:
	card_type = given_card_type
	open()


# opens the menu in its current state
func open() -> void:
	%MenuName.text = card_type.name
	visible = true
	%CardTypeNameBox.text = card_type.name
	%SubTypeOptions.setup(card_type)
	%DeckOptions.setup(card_type)
	%CardBackground.texture = card_type.card_back_texture


func close() -> void:
	visible = false
	%SubTypeOptions.close()
	%DeckOptions.close()


func _on_back_button_pressed() -> void:
	if visible:
		close()
		%MainMenu.open()


func _on_card_type_name_box_text_submitted(new_text: String) -> void:
	# if the text isn't empty
	if new_text != "":
		card_type.name = new_text
		%MenuName.text = new_text
		return
	
	# reset the text if it is empty
	%CardTypeNameBox.text = card_type.name


func _on_add_sub_type_button_pressed() -> void:
	card_type.add_empty_sub_type()
	%SubTypeOptions.reset()
