class_name CardMakerMainMenu
extends CardMakerMenu


func setup_main_menu() -> void:
	change_menu_name.emit("Card Types")
	change_card_background.emit(null)
	_setup_card_type_buttons()


func _setup_card_type_buttons() -> void:
	# set up the buttons for each card type
	for card_type in GlobalVariables.card_types:
		var new_single_type_option : ButtonAndDelete = GlobalVariables.BUTTON_AND_DELETE_SCENE.instantiate()
		new_single_type_option.setup(card_type)
		new_single_type_option.name_button_pressed.connect(_on_button_pressed)
		new_single_type_option.delete_button_pressed.connect(_on_delete_button_pressed)
		%CardTypeOptionsMenu.add_child(new_single_type_option)


func reset() -> void:
	for child in %CardTypeOptionsMenu.get_children():
		child.queue_free()
	_setup_card_type_buttons()


func _on_button_pressed(card_type : CardType) -> void:
	var new_menu: CardMakerMenu= GlobalVariables.CARD_TYPE_MENU_SCENE.instantiate()
	new_menu.setup_card_type_menu(card_type)
	add_sibling(new_menu)
	connect_to_new_menu.emit(new_menu)
	queue_free()


func _on_delete_button_pressed(card_type : CardType) -> void:
	if not await %DeleteMenu.ask_to_delete(card_type.name):
		return
	
	GlobalVariables.delete_card_type(card_type)
	reset()


func _on_card_type_button_pressed() -> void:
	GlobalVariables.add_new_card_type()
	reset()
