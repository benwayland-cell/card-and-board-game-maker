class_name TableEditorUI
extends Control

signal add_node

const editor_stack_scene: PackedScene = preload("uid://cbxdvjbwy6pws")


func _on_file_id_pressed(id: int) -> void:
	match id:
		0:
			print("Save")
		1:
			print("Save As")
		2:
			print("Export")
		3:
			print("Import")


func _on_insert_id_pressed(id: int) -> void:
	match id:
		0:
			add_node.emit(editor_stack_scene)
		1:
			print("Insert Single Snap")


func _on_play_id_pressed(id: int) -> void:
	match id:
		0:
			print("Play Game")
