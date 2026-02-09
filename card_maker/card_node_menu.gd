extends VBoxContainer

var card_sub_type : CardSubType

func setup() -> void:
	card_sub_type = %CardSubTypeMenu.card_sub_type
	for node in card_sub_type.get_default_card_nodes():
		%CardBackground.add_child(node)
		
		var single_node_menu := SingleCardMenu.new(node)
		single_node_menu.setup()
		add_child(single_node_menu)


func close() -> void:
	for child in get_children():
		child.queue_free()
