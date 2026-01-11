class_name Card

extends Node2D


# mostly not changing variables changed by constructor
var card_front_location :Texture2D= preload("res://card/Test Card.png")
var card_back_location :Texture2D= preload("res://card/Test Card Back.png")
var variable_parts : Array[Node]

# variables
var selected := false
var mouse_offset := Vector2.ZERO
var is_snapping := false
var start_drag_mouse_pos := Vector2.ZERO
var face_up := false

const RIGHT_CLICK_MENU := preload("res://right_click_menu/right_click_menu.tscn")


func setup(given_name: String, given_card_front_location: Texture2D, given_card_back_location: CompressedTexture2D, given_variable_parts: Array[Node]) -> void:
	# init given variables
	name = given_name
	card_front_location = given_card_front_location
	card_back_location = given_card_back_location
	variable_parts = given_variable_parts
	
	# set the texture to a default
	%Sprite2D.texture = card_back_location
	
	# add all of the nodes in variable_parts to %VariableParts
	for node in variable_parts:
		%VariableParts.add_child(node)


func _process(_delta: float) -> void:
	if not selected:
		return
	
	for overlapping_area in %Area2D.get_overlapping_areas():
		_handle_snapping(overlapping_area)
		_handle_z_index(overlapping_area)
	
	_follow_mouse()


# handles snapping to this object
func _handle_snapping(overlapping_area : Area2D):
	if overlapping_area.has_method("check_for_snapping"):
			if overlapping_area.check_for_snapping():
				is_snapping = true
				global_position = overlapping_area.global_position
			else:
				is_snapping = false


# makes sure the z_index of this item is above everything else
func _handle_z_index(overlapping_area : Area2D):
	var other_z_index : int = overlapping_area.get_parent().z_index
	
	if z_index == other_z_index:
		z_index += 1
	elif z_index < other_z_index:
		# swap z_index
		var temp_data = other_z_index
		other_z_index = z_index
		z_index = temp_data
		
		# actually sets the other object's z_index to other_z_index
		overlapping_area.get_parent().z_index = other_z_index


# Moves the card to follow the mouse
func _follow_mouse():
	if is_snapping:
		return
	
	position = get_global_mouse_position() + mouse_offset


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("left_click"):
		if not event.is_pressed():
			selected = false
			
			if get_global_mouse_position() == start_drag_mouse_pos:
				_left_click()
			
		else:
			start_drag_mouse_pos = get_global_mouse_position()
			mouse_offset = position - start_drag_mouse_pos
			selected = true
	
	elif event.is_action("right_click") and event.is_released():
		_right_click()


func _left_click() -> void:
	flip_card()


func _right_click() -> void:
	var button_array :Array[CustomButton]= [
		CustomButton.new(self, "Flip Card", ButtonOptions.flip_card),
		CustomButton.new(self, "Test 1", ButtonOptions.test1),
		CustomButton.new(self, "Test 2", ButtonOptions.test2),
		CustomButton.new(self, "Test 3", ButtonOptions.test3)
	]
	var right_click_menu := RIGHT_CLICK_MENU.instantiate()
	right_click_menu.setup(self, button_array)


func flip_card() -> void:
	face_up = !face_up
	
	if face_up:
		%Sprite2D.texture = card_front_location
		%VariableParts.show()
	else:
		%Sprite2D.texture = card_back_location
		%VariableParts.hide()
