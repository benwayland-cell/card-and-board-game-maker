class_name CardSubType

var name : String
var card_front_texture : Texture2D
var number_labels : Array[Label]
var text_labels : Array[Label]

enum NodeTypes {NUMBER_LABEL, TEXT_LABEL}

var _node_location_dictionary : Dictionary[String, NodeLocation]
var _node_dictionary : Dictionary

func _init(given_name: String, given_card_front_texture: Texture2D,
		given_number_labels: Array[Label], given_text_labels: Array[Label]) -> void:
	name = given_name
	card_front_texture = given_card_front_texture
	number_labels = given_number_labels
	text_labels = given_text_labels
	_init_dictionaries()


func _init_dictionaries() -> void:
	for index in range(number_labels.size()):
		var label = number_labels[index]
		_node_location_dictionary[label.name] = NodeLocation.new(NodeTypes.NUMBER_LABEL, index)
		_node_dictionary[label.name] = int(label.text)
	
	for index in range(text_labels.size()):
		var label = text_labels[index]
		_node_location_dictionary[label.name] = NodeLocation.new(NodeTypes.TEXT_LABEL, index)
		_node_dictionary[label.name] = label.text


# returns a list of all of the nodes with updated values
func get_card_nodes(number_label_values : Array[int], text_label_values : Array[String]) -> Array[Node]:
	var nodes_to_return : Array[Node] = []
	
	# assign the given values to the nodes and add them to the list
	for index in range(number_labels.size()):
		number_labels[index].text = str(number_label_values[index])
		nodes_to_return.append(number_labels[index].duplicate())
	
	for index in range(text_labels.size()):
		text_labels[index].text = text_label_values[index]
		nodes_to_return.append(text_labels[index].duplicate())
	
	return nodes_to_return


# returns a list of all the nodes with default values
func get_default_card_nodes() -> Array[Node]:
	var nodes_to_return : Array[Node] = []
	
	# assign the given values to the nodes and add them to the list
	for index in range(number_labels.size()):
		number_labels[index].text = "1"
		nodes_to_return.append(number_labels[index].duplicate())
	
	for index in range(text_labels.size()):
		text_labels[index].text = "Lorem Ipsum"
		nodes_to_return.append(text_labels[index].duplicate())
	
	return nodes_to_return


func get_node_dictionary() -> Dictionary:
	return _node_dictionary.duplicate()


class NodeLocation:
	
	var node_type : NodeTypes
	var index : int
	
	func _init(given_node_type : NodeTypes, given_index : int) -> void:
		node_type = given_node_type
		index = given_index
