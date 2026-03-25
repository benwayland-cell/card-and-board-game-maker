@abstract
class_name MenuUI
extends VBoxContainer

@warning_ignore("unused_signal")
signal highlight_snap_location
@warning_ignore("unused_signal")
signal deselect

var associated_editor_snap_location: EditorSnapLocation

@abstract
func setup(editable_nodes_array: Array[EditorSnapLocation], current_highlighted: EditorSnapLocation) -> void

@abstract
func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void
