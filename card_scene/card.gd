extends Area2D
class_name Card

const RETURN_SPEED: float = 10.0

# nodes needed
@export_group("Private nodes")
@export var sprite: Sprite2D
@export var variable_parts_node: Node2D

# textures and physical parts
var card_front_texture: Texture2D
var card_back_texture: Texture2D
var variable_parts: Array[Node]

# variables used by processing
var disabled: bool = false # prevents _process from running
var selected := false # if it's been selected by the user
var mouse_offset := Vector2.ZERO # the offset from position to the mouse
var is_snapping := false # if it's snapping to a snap location
var start_drag_mouse_pos := Vector2.ZERO 
var face_up :bool
var current_texture: Texture2D # the current texture


func setup(given_card_front_texture: Texture2D, given_card_back_texture: Texture2D,
		given_variable_parts: Array[Node],
		given_pos: Vector2, is_face_up: bool
) -> void:
	# init given variables
	card_front_texture = given_card_front_texture
	card_back_texture = given_card_back_texture
	variable_parts = given_variable_parts
	position = given_pos
	face_up = is_face_up
	
	update_texture()
	
	# add all of the nodes in variable_parts to variable_parts_node
	for node in variable_parts:
		variable_parts_node.add_child(node)


func _process(delta: float) -> void:
	if disabled:
		return
	
	if not selected:
		z_index = 0
		_go_to_zero(delta)
		return
	
	z_index = 1
	
	for overlapping_area in get_overlapping_areas():
		if overlapping_area is SnapLocation:
			_handle_snapping_to_snap_location(overlapping_area)
	
	_follow_mouse()


# handles snapping to this object
func _handle_snapping_to_snap_location(overlapping_snap_location : SnapLocation):
	if not overlapping_snap_location.check_for_snapping(self):
		is_snapping = false
		return
	
	is_snapping = true
	if get_parent() != overlapping_snap_location:
		overlapping_snap_location.add_card_to_snap_location(self)
	
	global_position = overlapping_snap_location.global_position


# Moves the card to follow the mouse
func _follow_mouse():
	if is_snapping:
		return
	
	global_position = get_global_mouse_position() + mouse_offset


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if disabled:
		return
	
	if event.is_action("left_click"):
		if not event.is_pressed():
			selected = false
			
			if get_global_mouse_position() == start_drag_mouse_pos:
				_left_click()
		
		else:
			start_drag_mouse_pos = get_global_mouse_position()
			mouse_offset = global_position - start_drag_mouse_pos
			selected = true
	
	elif event.is_action("right_click") and event.is_released():
		_right_click()


func _handle_stopped_left_clicking() -> void:
	pass


func _left_click() -> void:
	flip_card()


func _right_click() -> void:
	var button_array :Array[CustomRightClickButton]= [
		CustomRightClickButton.new(self, "Flip Card", ButtonOptions.flip_card),
		CustomRightClickButton.new(self, "Test 1", ButtonOptions.test1),
		CustomRightClickButton.new(self, "Test 2", ButtonOptions.test2),
		CustomRightClickButton.new(self, "Test 3", ButtonOptions.test3)
	]
	var right_click_menu := GlobalVariables.RIGHT_CLICK_MENU_SCENE.instantiate()
	right_click_menu.setup(self, button_array)


func flip_card() -> void:
	face_up = !face_up
	
	update_texture()


# updates the texture given wether it is face up or not
func update_texture() -> void:
	if face_up:
		current_texture = card_front_texture
		sprite.texture = card_front_texture
		variable_parts_node.show()
	else:
		current_texture = card_back_texture
		sprite.texture = card_back_texture
		variable_parts_node.hide()


# makes a dictionary of all of the important data in the variable nodes
func get_variable_data() -> Dictionary:
	var variable_data : Dictionary = {}
	
	for node in variable_parts_node.get_children():
		var data_to_add
		
		if node is Label:
			var text : String = node.text
			if text.is_valid_int():
				data_to_add = int(text)
			else:
				data_to_add = text
		else:
			print("Unhandled Variable part in " + str(self) + ": " + str(node))
		
		variable_data[node.name] = data_to_add
	
	return variable_data


func _go_to_zero(delta: float) -> void:
	if position != Vector2.ZERO:
		position = position.slerp(Vector2.ZERO, RETURN_SPEED * delta)
