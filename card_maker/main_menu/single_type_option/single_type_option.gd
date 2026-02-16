class_name SingleTypeOption
extends HBoxContainer

signal name_button_pressed
signal delete_button_pressed

var card_type : CardType

func setup(given_card_type : CardType) -> void:
	card_type = given_card_type
	
	%NameButton.text = card_type.name


func _on_name_button_pressed() -> void:
	name_button_pressed.emit(card_type)


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(card_type)
