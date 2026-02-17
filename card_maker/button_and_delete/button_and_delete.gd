class_name ButtonAndDelete
extends HBoxContainer

signal name_button_pressed
signal delete_button_pressed

var associated_data : Variant

func setup(given_associated_data : Variant) -> void:
	associated_data = given_associated_data
	
	%NameButton.text = associated_data.name


func _on_name_button_pressed() -> void:
	name_button_pressed.emit(associated_data)


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(associated_data)
