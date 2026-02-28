extends HBoxContainer

var player: Player:
	set = _set_player

const NODE_MINIMUM_SIZE := Vector2(GlobalVariables.CARD_TEXTURE_WIDTH, GlobalVariables.CARD_TEXTURE_HEIGHT)
const CARD_OFFSET := NODE_MINIMUM_SIZE / 2.0


func _set_player(new_player: Player) -> void:
	# empty the children
	for child in get_children():
		child.queue_free()
	
	for card: Card in new_player.hand:
		add_child(_new_card_control_node(card))

func _new_card_control_node(card_to_attatch: Card) -> Control:
	var new_control_node := Control.new()
	# set size of control node
	new_control_node.custom_minimum_size = NODE_MINIMUM_SIZE
	
	# make a snap location for them to attatch to
	var new_single_snap: SingleSnap = Scenes.SINGLE_SNAP_SCENE.instantiate()
	new_single_snap.position = CARD_OFFSET
	
	new_single_snap.add_card_to_snap_location(card_to_attatch)
	new_control_node.add_child(new_single_snap)
	
	return new_control_node
