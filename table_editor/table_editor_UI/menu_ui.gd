@abstract
class_name MenuUI
extends VBoxContainer

signal highlight_snap_location
signal deselect

var associated_editor_snap_location: EditorSnapLocation

@abstract
func setup(editable_nodes_array: Array[EditorSnapLocation], current_highlighted: EditorSnapLocation) -> void

@abstract
func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void
