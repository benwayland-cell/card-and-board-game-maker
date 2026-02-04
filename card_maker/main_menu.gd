extends VBoxContainer

func open() -> void:
	%MenuName.text = "Card Types"
	visible = true
	
	# set up the buttons for each card type
	for card_type in GlobalVariables.card_types:
		var button := CustomCardTypeButton.new()
		button.text = card_type.name
		button.card_type = card_type
		button.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		button.connect("go_to_card_type", _on_button_pressed)
		add_child(button)
	
	# set up the add card type button
	var add_button := Button.new()
	add_button.text = "+ Card Type"
	add_button.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	add_button.connect("pressed", _on_add_card_type)
	add_child(add_button)


# cleans up the menu to be closed
func close() -> void:
	visible = false
	
	for child in get_children():
		child.queue_free()

func _on_button_pressed(card_type : CardType) -> void:
	close()
	%CardTypeMenu.open_card_type(card_type)


func _on_add_card_type() -> void:
	print("Add Card Type")
