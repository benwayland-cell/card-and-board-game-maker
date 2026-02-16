extends VBoxContainer

func open() -> void:
	%MenuName.text = "Card Types"
	visible = true
	%CardBackground.texture = null
	
	# set up the buttons for each card type
	for card_type in GlobalVariables.card_types:
		var button := CustomCardTypeButton.new()
		button.text = card_type.name
		button.card_type = card_type
		button.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		button.connect("go_to_card_type", _on_button_pressed)
		%CardTypeOptionsMenu.add_child(button)


# cleans up the menu to be closed
func close() -> void:
	visible = false
	
	for child in %CardTypeOptionsMenu.get_children():
		child.queue_free()


func _on_button_pressed(card_type : CardType) -> void:
	close()
	%CardTypeMenu.open_card_type(card_type)


func _on_card_type_button_pressed() -> void:
	print("Add Card Type")
