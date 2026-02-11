extends VBoxContainer

var card_sub_type : CardSubType


func setup(given_card_sub_type : CardSubType) -> void:
	card_sub_type = given_card_sub_type
	
	var current_node_location := CardSubType.NodeLocation.new(GlobalVariables.NodeTypes.NUMBER_LABEL, 0)
	for index in range(card_sub_type.number_labels.size()):
		var current_node : Node = card_sub_type.number_labels[index]
		%CardBackground.add_child(current_node)
		current_node_location.index = index
		
		var single_node_menu := SingleCardMenu.new(current_node_location, card_sub_type)
		single_node_menu.setup()
		add_child(single_node_menu)
	
	current_node_location.node_type = GlobalVariables.NodeTypes.TEXT_LABEL
	for index in range(card_sub_type.text_labels.size()):
		%CardBackground.add_child(card_sub_type.text_labels[index])
		current_node_location.index = index
		
		var single_node_menu := SingleCardMenu.new(current_node_location, card_sub_type)
		single_node_menu.setup()
		add_child(single_node_menu)
	


func close() -> void:
	for child in get_children():
		child.queue_free()
	
