class_name TableEditorUI
extends Control

signal add_node

const EDITOR_STACK_SCENE: PackedScene = preload("uid://cbxdvjbwy6pws")
const EDITOR_SINGLE_SNAP_SCENE: PackedScene = preload("uid://fnmtsa26r2ca")

const NONE_SELECTED_UI_SCENE: PackedScene = preload("uid://ixelqx4tweeu")
const EDITOR_STACK_UI_SCENE: PackedScene = preload("uid://c4hctcr2wcmvo")

@onready var variable_menu: Control = %VariableMenu

var editable_nodes_array: Array[EditorSnapLocation]

var current_highlighted: EditorSnapLocation:
	set = _set_current_highlighted


func _ready() -> void:
	var none_menu: NoneSelectedUI = variable_menu.get_child(0)
	none_menu.setup(editable_nodes_array, null)
	none_menu.highlight_snap_location.connect(_on_highlight_snap_location)


func update() -> void:
	variable_menu.get_child(0).reset(editable_nodes_array)


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
			add_node.emit(EDITOR_STACK_SCENE)
		1:
			add_node.emit(EDITOR_SINGLE_SNAP_SCENE)


func _on_play_id_pressed(id: int) -> void:
	match id:
		0:
			print("Play Game")


func _set_current_highlighted(new_node: EditorSnapLocation) -> void:
	if current_highlighted == new_node:
		return
	current_highlighted = new_node
	
	for editor_snap_location: EditorSnapLocation in editable_nodes_array:
		if editor_snap_location != new_node:
			editor_snap_location.highlighted = false
	
	for child in variable_menu.get_children():
		child.queue_free()
	
	var new_menu: MenuUI
	
	if current_highlighted is EditorStack:
		new_menu = EDITOR_STACK_UI_SCENE.instantiate()
	else:
		new_menu = NONE_SELECTED_UI_SCENE.instantiate()
	
	new_menu.associated_editor_snap_location = current_highlighted
	new_menu.setup(editable_nodes_array, current_highlighted)
	new_menu.highlight_snap_location.connect(_on_highlight_snap_location)
	new_menu.deselect.connect(_on_snap_location_deselect)
	variable_menu.add_child(new_menu)


func _on_highlight_snap_location(editor_snap_location: EditorSnapLocation) -> void:
	editor_snap_location.highlighted = true


func _on_snap_location_deselect() -> void:
	current_highlighted = null
