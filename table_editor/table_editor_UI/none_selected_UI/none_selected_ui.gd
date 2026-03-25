class_name NoneSelectedUI
extends MenuUI

var buttons: VBoxContainer

const NONE_SELECTED_BUTTON_SCENE: PackedScene = preload("uid://cfj5nhr6vdjgw")

func setup(editable_nodes_array: Array[EditorSnapLocation], _current_highlighted: EditorSnapLocation) -> void:
	buttons = %Buttons
	
	for editor_snap_location: EditorSnapLocation in editable_nodes_array:
		var new_button: NoneSelectedButton = NONE_SELECTED_BUTTON_SCENE.instantiate()
		new_button.setup(editor_snap_location, _on_button_press)
		buttons.add_child(new_button)


func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void:
	for child in buttons.get_children():
		child.queue_free()
	setup(editable_nodes_array, null)


func _on_button_press(editor_snap_location: EditorSnapLocation) -> void:
	highlight_snap_location.emit(editor_snap_location)
