class_name PlayerHand
extends Control

@export var camera: Camera2D
@export var change_size_speed: float = 10.0

@onready var h_box: HBoxContainer = %HBoxContainer

var player: Player:
	set = _set_player


const NODE_MINIMUM_SIZE := Vector2(GlobalVariables.CARD_TEXTURE_WIDTH, GlobalVariables.CARD_TEXTURE_HEIGHT)
const CARD_OFFSET := NODE_MINIMUM_SIZE / 2.0


func _ready() -> void:
	assert(camera != null, "Didn't export camera in player hand")


func _process(delta: float) -> void:
	_handle_pos()
	_handle_card_scale(delta)


func _handle_pos() -> void:
	scale = Vector2(1 / camera.zoom.x, 1 / camera.zoom.y)
	
	var y_cor = camera.global_position.y + (get_viewport_rect().size.y / 2) * scale.y
	var bottom_middle_cor := Vector2(camera.global_position.x , y_cor)
	global_position = bottom_middle_cor


func _handle_card_scale(delta: float) -> void:
	if player == null:
		return
	
	for card in player.hand:
		var target_card_scale: Vector2
		if card.selected and not card.is_snapping:
			target_card_scale = camera.zoom
		else:
			target_card_scale = Vector2.ONE
		
		card.scale = card.scale.slerp(target_card_scale, change_size_speed * delta)


func _set_player(new_player: Player) -> void:
	# empty the children
	for child in h_box.get_children():
		child.queue_free()
	
	for card: Card in new_player.hand:
		h_box.add_child(_new_card_control_node(card))
	
	player = new_player


func _new_card_control_node(card_to_attatch: Card) -> Control:
	var new_control_node := Control.new()
	# set size of control node
	new_control_node.custom_minimum_size = NODE_MINIMUM_SIZE
	new_control_node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# make a snap location for them to attatch to
	var new_single_snap: PlayerHandSnap = Scenes.PLAYER_HAND_SNAP_SCENE.instantiate()
	new_single_snap.position = CARD_OFFSET
	new_single_snap.remove_card.connect(_on_snap_location_remove_card)
	
	new_single_snap.add_card_to_snap_location(card_to_attatch)
	new_control_node.add_child(new_single_snap)
	
	return new_control_node


func _on_snap_location_remove_card(card_to_remove: Card) -> void:
	player.remove_card(card_to_remove)
