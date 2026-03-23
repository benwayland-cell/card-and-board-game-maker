class_name NoneSelectedButton
extends Button

signal editor_snap_pressed
var associated_editor_snap_location: EditorSnapLocation


func setup(editor_snap_location: EditorSnapLocation, to_connect_to: Callable) -> void:
	associated_editor_snap_location = editor_snap_location
	text = editor_snap_location.name
	editor_snap_pressed.connect(to_connect_to)


func _on_pressed() -> void:
	editor_snap_pressed.emit(associated_editor_snap_location)
