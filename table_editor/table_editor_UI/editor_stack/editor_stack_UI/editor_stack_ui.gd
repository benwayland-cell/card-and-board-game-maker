class_name EditorStackUI
extends MenuUI

@onready var name_line_edit: LineEdit = %NameLineEdit
@onready var shuffle_button: Button = %ShuffleButton
@onready var face_up_button: Button = %FaceUpButton
@onready var choose_deck_button: Button = %ChooseDeckButton
@onready var choose_deck_popup_menu: ChooseDeckPopupMenu = %ChooseDeckPopupMenu

var current_highlighted: EditorStack


func _ready() -> void:
	name_line_edit.text = current_highlighted.name
	_set_shuffle_button_text()
	_set_face_up_button_text()
	_set_choose_deck_button_text()


func setup(_editable_nodes_array: Array[EditorSnapLocation], given_current_highlighted: EditorSnapLocation) -> void:
	assert(given_current_highlighted is EditorStack, "Editor Stack UI was initialized not using an EditorStack")
	current_highlighted = given_current_highlighted


func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void:
	setup(editable_nodes_array, current_highlighted)


func _set_shuffle_button_text() -> void:
	if current_highlighted.shuffle:
		shuffle_button.text = "True"
	else:
		shuffle_button.text = "False"


func _set_face_up_button_text() -> void:
	if current_highlighted.face_up:
		face_up_button.text = "True"
	else:
		face_up_button.text = "False"


func _set_choose_deck_button_text() -> void:
	if current_highlighted.starting_deck == null:
		choose_deck_button.text = "None"
	else:
		choose_deck_button.text = current_highlighted.starting_deck.name


func _on_deselect_button_pressed() -> void:
	deselect.emit()


func _on_name_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		name_line_edit.text = current_highlighted.name
		return
	
	current_highlighted.name = new_text


func _on_shuffle_button_pressed() -> void:
	current_highlighted.shuffle = not current_highlighted.shuffle
	_set_shuffle_button_text()


func _on_face_up_button_pressed() -> void:
	current_highlighted.face_up = not current_highlighted.face_up
	_set_face_up_button_text()


func _on_choose_deck_button_pressed() -> void:
	var data = await choose_deck_popup_menu.get_deck()
	current_highlighted.starting_deck = data[0]
	current_highlighted.starting_deck_card_type = data[1]
	_set_choose_deck_button_text()
