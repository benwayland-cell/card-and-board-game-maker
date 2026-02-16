class_name SingleSubTypeOption
extends HBoxContainer

signal name_button_pressed
signal delete_button_pressed

var sub_type : CardSubType

func setup(given_sub_type : CardSubType) -> void:
	sub_type = given_sub_type
	
	%NameButton.text = sub_type.name


func _on_name_button_pressed() -> void:
	name_button_pressed.emit(sub_type)


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(sub_type)
