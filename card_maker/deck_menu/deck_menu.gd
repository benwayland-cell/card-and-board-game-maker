extends VBoxContainer

var card_type : CardType
var deck : Deck


func open_with_deck(given_card_type : CardType, given_deck : Deck):
	card_type = given_card_type
	deck = given_deck
	open()


func open() -> void:
	visible = true
	_update_menu_name()
	%DeckNameLineEdit.text = deck.name
	_setup_single_card_menus()


func _update_menu_name() -> void:
	%MenuName.text = %CardTypeMenu.card_type.name + " / " + deck.name


func close() -> void:
	visible = false
	
	for child in %SingleCardMenus.get_children():
		child.queue_free()


func _setup_single_card_menus() -> void:
	for card_data: CardData in deck.deck_data:
		var new_single_card_menu: SingleCardMenu= GlobalVariables.SINGLE_CARD_MENU_SCENE.instantiate()
		new_single_card_menu.setup(card_type, card_data)
		new_single_card_menu.connect("delete_card", _on_delete_card)
		%SingleCardMenus.add_child(new_single_card_menu)


func _reset_single_card_menus() -> void:
	for child in %SingleCardMenus.get_children():
		child.queue_free()
	
	_setup_single_card_menus()


func _on_back_button_pressed() -> void:
	if not visible:
		return
	
	close()
	%CardTypeMenu.open()


func _on_deck_name_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		%DeckNameLineEdit.text = deck.name
		return
	
	deck.name = new_text


func _on_delete_card(card_data_to_delete: CardData) -> void:
	deck.delete_card(card_data_to_delete)
	_reset_single_card_menus()


func _on_add_card_button_pressed() -> void:
	deck.add_new_card()
	_reset_single_card_menus()
