extends VBoxContainer

var card_sub_type : CardSubType

@onready var single_node_menu_scene : PackedScene = preload("res://card_maker/single_node_menu.tscn")

func setup(given_card_sub_type : CardSubType) -> void:
	card_sub_type = given_card_sub_type
	
	var current_node_location := CardSubType.NodeLocation.new(GlobalVariables.NodeTypes.NUMBER_LABEL, 0)
	for index in range(card_sub_type.number_labels.size()):
		var current_node : Node = card_sub_type.number_labels[index]
		%CardBackground.add_child(current_node)
		current_node_location.index = index
		
		var single_node_menu := single_node_menu_scene.instantiate()
		single_node_menu.setup(current_node_location, card_sub_type)
		single_node_menu.connect("delete_button_pressed", _on_node_delete_button_pressed)
		%SingleNodeMenus.add_child(single_node_menu)
	
	current_node_location.node_type = GlobalVariables.NodeTypes.TEXT_LABEL
	for index in range(card_sub_type.text_labels.size()):
		%CardBackground.add_child(card_sub_type.text_labels[index])
		current_node_location.index = index
		
		var single_node_menu := single_node_menu_scene.instantiate()
		single_node_menu.setup(current_node_location, card_sub_type)
		single_node_menu.connect("delete_button_pressed", _on_node_delete_button_pressed)
		%SingleNodeMenus.add_child(single_node_menu)


func close() -> void:
	for child in %SingleNodeMenus.get_children():
		child.queue_free()
	
	for child in %CardBackground.get_children():
		%CardBackground.remove_child(child)


func _on_node_delete_button_pressed (node : Node):
	# check if the user want to delete it
	if not await %DeleteMenu.ask_to_delete_node(node.name):
		return
	
	card_sub_type.delete_node(node)
	close()
	setup(card_sub_type)
