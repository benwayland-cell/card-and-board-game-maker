class_name CardSubType

#const DEFAULT_NUMBER_LABEL_NAME : String = "New Number Label"
#const DEFAULT_NUMBER_LABEL_VALUE : int = 1
#
#const DEFAULT_TEXT_LABEL_NAME : String = "New Text Label"
#const DEFAULT_TEXT_LABEL_VALUE : String = "Lorem Ipsum"

var name : String
var card_front_texture : Texture2D
var card_nodes : Array[CardNode]
#var number_labels : Array[Label]
#var text_labels : Array[Label]

#var _node_location_dictionary : Dictionary[String, int]
#var _node_location_dictionary : Dictionary[String, NodeLocation]
#var _node_dictionary : Dictionary[String, Node]


func _init(given_name: String, given_card_front_texture: Texture2D, given_card_nodes : Array[CardNode]) -> void:
	name = given_name
	card_front_texture = given_card_front_texture
	card_nodes = given_card_nodes
	#_init_dictionaries()


#func _init_dictionaries() -> void:
	#for index in range(card_nodes.size()):
		#var card_node : CardNode = card_nodes[index]
		#var node_name : String = card_node.node.name
		#_node_location_dictionary[node_name] = index
	
	#for index in range(number_labels.size()):
		#var label = number_labels[index]
		#_node_location_dictionary[label.name] = NodeLocation.new(CardNode.NodeTypes.NUMBER_LABEL, index)
		#_node_dictionary[label.name] = int(label.text)
	#
	#for index in range(text_labels.size()):
		#var label = text_labels[index]
		#_node_location_dictionary[label.name] = NodeLocation.new(CardNode.NodeTypes.TEXT_LABEL, index)
		#_node_dictionary[label.name] = label.text


# returns a list of all of the nodes with updated values
func get_card_nodes(card_data_array : Array) -> Array[Node]:
	var nodes_to_return : Array[Node] = []
	assert(card_data_array.size() == card_nodes.size())
	
	for index in range(card_nodes.size()):
		var card_node : CardNode = card_nodes[index]
		
		var new_node = card_node.node.duplicate()
		var current_value = card_data_array[index]
		
		match card_node.node_type:
			CardNode.NodeTypes.NUMBER_LABEL:
				assert(new_node is Label)
				assert(current_value is int)
				new_node.text = str(current_value)
				
			CardNode.NodeTypes.TEXT_LABEL:
				assert(new_node is Label)
				assert(current_value is String)
				new_node.text = current_value
		
		nodes_to_return.append(new_node)
	
	return nodes_to_return
	
	#var nodes_to_return : Array[Node] = []
	#
	#for key in new_node_dictionary.keys():
		#if not _node_location_dictionary.has(key):
			#continue
		#
		#var node_location : NodeLocation = _node_location_dictionary[key]
		#var value = new_node_dictionary[key]
		#
		#var node_type : CardNode.NodeTypes = node_location.node_type
		#match node_type:
			#CardNode.NodeTypes.NUMBER_LABEL:
				#var label : Label = number_labels[node_location.index]
				#label.text = str(value)
				#nodes_to_return.append(label.duplicate())
			#CardNode.NodeTypes.TEXT_LABEL:
				#var label : Label = text_labels[node_location.index]
				#label.text = value
				#nodes_to_return.append(label.duplicate())
	#
	#return nodes_to_return


# returns a list of all the nodes with default values
#func get_default_card_nodes() -> Array[Node]:
	#var nodes_to_return : Array[Node] = []
	#
	## assign the given values to the nodes and add them to the list
	#for index in range(number_labels.size()):
		#number_labels[index].text = "1"
		#nodes_to_return.append(number_labels[index].duplicate())
	#
	#for index in range(text_labels.size()):
		#text_labels[index].text = "Lorem Ipsum"
		#nodes_to_return.append(text_labels[index].duplicate())
	#
	#return nodes_to_return


#func get_node_dictionary() -> Dictionary:
	#return _node_dictionary.duplicate()


#func delete_node(node_to_delete : Node) -> void:
	#_node_location_dictionary.erase(node_to_delete.name)
	#_node_dictionary.erase(node_to_delete.name)
	#
	#for node in number_labels:
		#if node.name == node_to_delete.name:
			#number_labels.erase(node)
			#return
	#
	#for node in text_labels:
		#if node.name == node_to_delete.name:
			#text_labels.erase(node)
			#return


#func add_new_number_label_node() -> Node:
	#var new_label = Label.new()
	#new_label.label_settings = GlobalVariables.simple_label_settings
	#new_label.name = DEFAULT_NUMBER_LABEL_NAME
	#new_label.text = str(DEFAULT_NUMBER_LABEL_VALUE)
	#
	#number_labels.append(new_label)
	#_node_location_dictionary[new_label.name] = (
			#NodeLocation.new(GlobalVariables.NodeTypes.NUMBER_LABEL, number_labels.size() - 1))
	#_node_dictionary[new_label.name] = DEFAULT_NUMBER_LABEL_VALUE
	#
	#return new_label
#
#
#func add_new_text_label_node() -> Node:
	#var new_label = Label.new()
	#new_label.label_settings = GlobalVariables.simple_label_settings
	#new_label.name = DEFAULT_TEXT_LABEL_NAME
	#new_label.text = DEFAULT_TEXT_LABEL_VALUE
	#
	#text_labels.append(new_label)
	#_node_location_dictionary[new_label.name] = (
			#NodeLocation.new(GlobalVariables.NodeTypes.TEXT_LABEL, text_labels.size() - 1))
	#_node_dictionary[new_label.name] = DEFAULT_TEXT_LABEL_VALUE
	#
	#return new_label


#class NodeLocation:
	#
	#var node_type : CardNode.NodeTypes
	#var index : int
	#
	#func _init(given_node_type : CardNode.NodeTypes, given_index : int) -> void:
		#node_type = given_node_type
		#index = given_index
