extends VBoxContainer

var node : Node
var card_sub_type : CardSubType
var node_location : CardSubType.NodeLocation


func setup(given_node_location : CardSubType.NodeLocation, given_card_sub_type : CardSubType) -> void:
	card_sub_type = given_card_sub_type
	node_location = given_node_location
	
	match node_location.node_type:
		GlobalVariables.NodeTypes.NUMBER_LABEL:
			node = card_sub_type.number_labels[node_location.index]
			
		GlobalVariables.NodeTypes.TEXT_LABEL:
			node = card_sub_type.text_labels[node_location.index]
	
	%NameLineEdit.text = node.name
	%XCorSpinBox.value = node.position.x
	%YCorSpinBox.value = node.position.y



func _on_name_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		%NameLineEdit.text = node.name
		return
	
	node.name = new_text


func _on_x_cor_spin_box_value_changed(value: float) -> void:
	node.position.x = value


func _on_y_cor_spin_box_value_changed(value: float) -> void:
	node.position.y = value
