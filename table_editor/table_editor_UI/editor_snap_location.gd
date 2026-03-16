class_name EditorSnapLocation
extends Area2D

@onready var highlight_rect: ColorRect = %Highlight

var selected := false # if it's been selected by the user
var mouse_offset := Vector2.ZERO # the offset from position to the mouse
var start_drag_mouse_pos := Vector2.ZERO 
var highlighted = false:
	set = _set_highlighted


func _process(_delta: float) -> void:
	_handle_deselecting_mouse()
	_follow_mouse()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("left_click") and event.is_pressed():
		start_drag_mouse_pos = get_global_mouse_position()
		mouse_offset = global_position - start_drag_mouse_pos
		selected = true
		highlighted = true


func _handle_deselecting_mouse() -> void:
	if not (Input.is_action_just_released("left_click") and selected):
		return
	
	selected = false
	
	#if get_global_mouse_position() == start_drag_mouse_pos:
		#_left_click()


# Moves the card to follow the mouse
func _follow_mouse():
	if not selected:
		return
	
	global_position = get_global_mouse_position() + mouse_offset


func _set_highlighted(new_value: bool) -> void:
	highlighted = new_value
	highlight_rect.visible = highlighted
	
	var parent = get_parent()
	if highlighted and parent != null:
		print(parent.name)
		parent.move_child(self, parent.get_child_count())
