class_name EditorStackUI
extends MenuUI

@onready var name_line_edit: LineEdit = %NameLineEdit


func _ready() -> void:
	name_line_edit.text = name


func setup(_editable_nodes_array: Array[EditorSnapLocation]) -> void:
	pass


func reset(editable_nodes_array: Array[EditorSnapLocation]) -> void:
	setup(editable_nodes_array)
