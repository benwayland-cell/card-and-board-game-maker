extends CardMakerMenu

var card_type: CardType

const BACK_BUTTON_MENU: PackedScene= GlobalVariables.MAIN_MENU_SCENE

func setup_card_type_menu(given_card_type : CardType) -> void:
	card_type = given_card_type
	_setup_children()


func _setup_children() -> void:
	change_menu_name.emit(card_type.name)
	%CardTypeNameBox.text = card_type.name
	%SubTypeOptions.setup(card_type)
	%DeckOptions.setup(card_type)
	change_card_background.emit(card_type.card_back_texture)


func close() -> void:
	%SubTypeOptions.close()
	%DeckOptions.close()


func reset() -> void:
	close()
	_setup_children()


func on_back_button_pressed() -> void:
	print(GlobalVariables.MAIN_MENU_SCENE)
	var new_menu: CardMakerMenu= BACK_BUTTON_MENU.instantiate()
	new_menu.setup_main_menu()
	add_sibling(new_menu)
	connect_to_new_menu.emit(new_menu)
	queue_free()


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


func _on_add_deck_button_pressed() -> void:
	card_type.add_empty_deck()
	%DeckOptions.reset()
