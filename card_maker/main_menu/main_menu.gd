extends VBoxContainer

func open() -> void:
	%MenuName.text = "Card Types"
	visible = true
	%CardBackground.texture = null
	
	# set up the buttons for each card type
	for card_type in GlobalVariables.card_types:
		var new_single_type_option : ButtonAndDelete = GlobalVariables.BUTTON_AND_DELETE_SCENE.instantiate()
		new_single_type_option.setup(card_type)
		new_single_type_option.connect("name_button_pressed", _on_button_pressed)
		new_single_type_option.connect("delete_button_pressed", _on_delete_button_pressed)
		%CardTypeOptionsMenu.add_child(new_single_type_option)


# cleans up the menu to be closed
func close() -> void:
	visible = false
	
	for child in %CardTypeOptionsMenu.get_children():
		child.queue_free()


func reset() -> void:
	close()
	open()


func _on_button_pressed(card_type : CardType) -> void:
	close()
	%CardTypeMenu.open_card_type(card_type)


func _on_delete_button_pressed(card_type : CardType) -> void:
	if not await %DeleteMenu.ask_to_delete(card_type.name):
		return
	
	GlobalVariables.delete_card_type(card_type)
	reset()


func _on_card_type_button_pressed() -> void:
	GlobalVariables.add_new_card_type()
	reset()
