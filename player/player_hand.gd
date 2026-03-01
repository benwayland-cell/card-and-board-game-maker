extends HBoxContainer

@export var change_size_speed: float = 10.0

var player: Player:
	set = _set_player


const NODE_MINIMUM_SIZE := Vector2(GlobalVariables.CARD_TEXTURE_WIDTH, GlobalVariables.CARD_TEXTURE_HEIGHT)
const CARD_OFFSET := NODE_MINIMUM_SIZE / 2.0


func _process(delta: float) -> void:
	if player == null:
		return
	
	for card in player.hand:
		var target_card_scale: Vector2
		if card.selected and not card.is_snapping:
			target_card_scale = GlobalVariables.camera_zoom
		else:
			target_card_scale = Vector2.ONE
		
		card.scale = card.scale.slerp(target_card_scale, change_size_speed * delta)


func _set_player(new_player: Player) -> void:
	# empty the children
	for child in get_children():
		child.queue_free()
	
	for card: Card in new_player.hand:
		add_child(_new_card_control_node(card))
	
	player = new_player

func _new_card_control_node(card_to_attatch: Card) -> Control:
	var new_control_node := Control.new()
	# set size of control node
	new_control_node.custom_minimum_size = NODE_MINIMUM_SIZE
	new_control_node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# make a snap location for them to attatch to
	var new_single_snap: SingleSnap = Scenes.SINGLE_SNAP_SCENE.instantiate()
	new_single_snap.position = CARD_OFFSET
	new_single_snap.sprite.texture = null
	
	new_single_snap.add_card_to_snap_location(card_to_attatch)
	new_control_node.add_child(new_single_snap)
	
	return new_control_node
