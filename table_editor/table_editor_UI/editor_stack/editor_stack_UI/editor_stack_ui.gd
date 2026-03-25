class_name EditorStackUI
extends MenuUI

@onready var name_line_edit: LineEdit = %NameLineEdit

var current_highlighted: EditorStack


func _ready() -> void:
	name_line_edit.text = name


func setup(_editable_nodes_array: Array[EditorSnapLocation], given_current_highlighted: EditorSnapLocation) -> void:
	assert(given_current_highlighted is EditorStack, "Editor Stack UI was initialized not using an EditorStack")
	current_highlighted = given_current_highlighted


func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void:
	setup(editable_nodes_array, current_highlighted)


func _on_deselect_button_pressed() -> void:
	deselect.emit()


func _on_name_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		name_line_edit.text = current_highlighted.name
		return
	
	current_highlighted.name = new_text
