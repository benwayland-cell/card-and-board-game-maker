class_name TableEditor
extends Node2D


@onready var table_editor_ui: TableEditorUI = %TableEditorUi
@onready var editable_nodes: Node = %EditableNodes


func _ready() -> void:
	table_editor_ui.add_node.connect(add_node)


func add_node(packed_scene: PackedScene) -> void:
	var new_scene = packed_scene.instantiate()
	editable_nodes.add_child(new_scene)
