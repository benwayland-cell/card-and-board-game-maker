class_name CardNode
extends Node

enum NodeTypes {NUMBER_LABEL, TEXT_LABEL}

var node : Node
var node_type : NodeTypes


func _init(given_node : Node, given_node_type : NodeTypes) -> void:
	node = given_node
	node_type = given_node_type


func get_value() -> Variant:
	match node_type:
		NodeTypes.NUMBER_LABEL:
			assert(node is Label)
			return int(node.text)
		
		NodeTypes.TEXT_LABEL:
			assert(node is Label)
			return node.text
	
	return null


func set_value(new_value: Variant) -> void:
	match node_type:
		NodeTypes.NUMBER_LABEL:
			assert(node is Label)
			assert(new_value is int)
			node.text = str(new_value)
		
		NodeTypes.TEXT_LABEL:
			assert(node is Label)
			assert(new_value is String)
			node.text = new_value
