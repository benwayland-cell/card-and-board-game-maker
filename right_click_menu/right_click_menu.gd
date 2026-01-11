class_name RightClickMenu

extends Control

var mouse_is_hovering := false
var buttons_to_add :Array[CustomButton]


func _ready() -> void:
	_handle_scale()


func setup(node_to_attatch_to: Node, buttons : Array[CustomButton]) -> void:
	# attatch all given buttons to self
	for button in buttons:
		$MarginContainer/VBoxContainer.add_child(button)
	
	# attatch self and setup position
	node_to_attatch_to.add_child(self)
	position = get_local_mouse_position()


func _process(_delta: float) -> void:
	_handle_scale()
	# close if any of these things happen
	
	if (
			(Input.is_action_just_pressed("left_click") and not mouse_is_hovering)
			or Input.is_action_just_pressed("right_click")
	):
		queue_free()


func _on_mouse_entered() -> void:
	mouse_is_hovering = true


func _on_mouse_exited() -> void:
	mouse_is_hovering = false


# fixes the size relative to the zoom of the camera
func _handle_scale() -> void:
	var camera_zoom = GlobalVariables.camera_zoom
	scale = Vector2(1 / camera_zoom.x, 1 / camera_zoom.y)
