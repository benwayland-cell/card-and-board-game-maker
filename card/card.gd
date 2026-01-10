extends Node2D

class_name Card

const RIGHT_CLICK_MENU := preload("res://right_click_menu/right_click_menu.tscn")

var selected := false
var mouse_offset := Vector2.ZERO
var is_snapping := false
var start_drag_mouse_pos := Vector2.ZERO

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
	print("left click card")

func _right_click() -> void:
	var right_click_menu = RIGHT_CLICK_MENU.instantiate()
	add_child(right_click_menu)
	right_click_menu.position = get_local_mouse_position()
