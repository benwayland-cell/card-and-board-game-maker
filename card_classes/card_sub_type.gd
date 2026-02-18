class_name CardSubType

const DEFAULT_NUMBER_LABEL_NAME : String = "New Number Label"
const DEFAULT_NUMBER_LABEL_VALUE : int = 1

const DEFAULT_TEXT_LABEL_NAME : String = "New Text Label"
const DEFAULT_TEXT_LABEL_VALUE : String = "Lorem Ipsum"

var name : String
var card_front_texture : Texture2D
var card_nodes : Array[CardNode]


func _init(given_name: String, given_card_front_texture: Texture2D, given_card_nodes : Array[CardNode]) -> void:
	name = given_name
	card_front_texture = given_card_front_texture
	card_nodes = given_card_nodes


# returns a list of all of the nodes with updated values
func get_card_nodes(card_data_dict : Dictionary[CardNode, Variant]) -> Array[Node]:
	var nodes_to_return : Array[Node] = []
	
	for index in range(card_nodes.size()):
		var card_node : CardNode = card_nodes[index]
		var new_node = card_node.node.duplicate()
		
		if not card_data_dict.has(card_node):
			continue
		
		var current_value = card_data_dict[card_node]
		
		# leave the value to its default if null
		if current_value == null:
			nodes_to_return.append(new_node)
			continue
		
		match card_node.node_type:
			CardNode.NodeTypes.NUMBER_LABEL:
				assert(new_node is Label, "Failed node: %s" % new_node)
				assert(current_value is int, "Failed value: %s" % current_value)
				new_node.text = str(current_value)
			
			CardNode.NodeTypes.TEXT_LABEL:
				assert(new_node is Label)
				assert(current_value is String)
				new_node.text = current_value
		
		nodes_to_return.append(new_node)
	
	return nodes_to_return


func delete_node(node_to_delete : Node) -> void:
	for index in range(card_nodes.size()):
		var card_node : CardNode = card_nodes[index]
		if node_to_delete == card_node.node:
			card_nodes.remove_at(index)
			return


func add_new_number_label_node() -> Node:
	var new_label = Label.new()
	new_label.label_settings = GlobalVariables.simple_label_settings
	new_label.name = DEFAULT_NUMBER_LABEL_NAME
	new_label.text = str(DEFAULT_NUMBER_LABEL_VALUE)
	
	var new_card_node := CardNode.new(new_label, CardNode.NodeTypes.NUMBER_LABEL)
	card_nodes.append(new_card_node)
	
	return new_label


func add_new_text_label_node() -> Node:
	var new_label = Label.new()
	new_label.label_settings = GlobalVariables.simple_label_settings
	new_label.name = DEFAULT_TEXT_LABEL_NAME
	new_label.text = DEFAULT_TEXT_LABEL_VALUE
	
	var new_card_node := CardNode.new(new_label, CardNode.NodeTypes.TEXT_LABEL)
	card_nodes.append(new_card_node)
	
	return new_label
