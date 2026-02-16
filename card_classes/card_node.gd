class_name CardNode
extends Node

enum NodeTypes {NUMBER_LABEL, TEXT_LABEL}

var node : Node
var node_type : NodeTypes


func _init(given_node : Node, given_node_type : NodeTypes) -> void:
	node = given_node
	node_type = given_node_type
