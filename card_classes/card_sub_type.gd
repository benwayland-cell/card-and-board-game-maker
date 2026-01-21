class_name CardSubType

var name : String
var card_front_texture : Texture2D
var number_labels : Array[Label]
var text_labels : Array[Label]

func _init(given_name: String, given_card_front_texture: Texture2D, given_number_labels: Array[Label], given_text_labels: Array[Label]) -> void:
	name = given_name
	card_front_texture = given_card_front_texture
	number_labels = given_number_labels
	text_labels = given_text_labels


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
