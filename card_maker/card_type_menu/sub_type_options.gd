extends VBoxContainer

var card_type : CardType
var sub_types : Array[CardSubType]

func setup(given_card_type : CardType) -> void:
	card_type = given_card_type
	sub_types = card_type.sub_types
	_setup_buttons()

func _setup_buttons() -> void:
	for sub_type in sub_types:
		var new_sub_type_option : SingleSubTypeOption = GlobalVariables.SINGLE_SUB_TYPE_OPTION_SCENE.instantiate()
		new_sub_type_option.setup(sub_type)
		new_sub_type_option.connect("name_button_pressed", _on_button_pressed)
		new_sub_type_option.connect("delete_button_pressed", _on_delete_button_pressed)
		
		add_child(new_sub_type_option)

func close() -> void:
	for child in get_children():
		child.queue_free()


func reset() -> void:
	close()
	_setup_buttons()


func _on_button_pressed(card_sub_type : CardSubType) -> void:
	%CardTypeMenu.close()
	%CardSubTypeMenu.open_with_sub_type(card_sub_type)


func _on_delete_button_pressed(card_sub_type : CardSubType) -> void:
	if not await %DeleteMenu.ask_to_delete(card_sub_type.name):
		return
	
	card_type.delete_sub_type(card_sub_type)
	reset()
