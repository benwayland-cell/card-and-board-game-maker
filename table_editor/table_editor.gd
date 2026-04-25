class_name TableEditor
extends Node2D

@onready var table_editor_ui: TableEditorUI = %TableEditorUi
@onready var editable_nodes: Node = %EditableNodes

var editable_nodes_array: Array[EditorSnapLocation]


func _ready() -> void:
	table_editor_ui.add_node.connect(add_node)
	table_editor_ui.editable_nodes_array = editable_nodes_array


func add_node(packed_scene: PackedScene) -> void:
	var new_scene: EditorSnapLocation = packed_scene.instantiate()
	editable_nodes.add_child(new_scene)
	editable_nodes_array.append(new_scene)
	new_scene.just_highlighted.connect(_on_snap_location_just_highlighted)
	table_editor_ui.update()


func _on_snap_location_just_highlighted(editor_snap_location: EditorSnapLocation) -> void:
	table_editor_ui.current_highlighted = editor_snap_location


func _on_table_editor_ui_save() -> void:
	GlobalVariables.table_save_data = GlobalVariables.SaveData.make_save_data_array(editable_nodes_array)
