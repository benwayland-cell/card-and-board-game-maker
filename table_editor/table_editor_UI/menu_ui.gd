@abstract
class_name MenuUI
extends VBoxContainer

signal highlight_snap_location

@abstract
func setup(editable_nodes_array: Array[EditorSnapLocation]) -> void

@abstract
func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void
