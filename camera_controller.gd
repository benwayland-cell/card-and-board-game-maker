extends Camera2D

@export var zoom_factor := 0.1
@export var zoom_speed := 10
@export var simple_pan_speed := 1000

var zoom_target :Vector2
var drag_start_mouse_pos := Vector2.ZERO
var drag_start_camera_pos := Vector2.ZERO
var is_dragging := false

func _ready() -> void:
	zoom_target = zoom

func _process(delta: float) -> void:
	_zoom(delta)
	_simple_pan(delta)
	_click_and_drag()
	
	GlobalVariables.camera_zoom = zoom

func _zoom(delta: float) -> void:
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom_target *= 1 + zoom_factor
	
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom_target *= 1 - zoom_factor
	
	zoom = zoom.slerp(zoom_target, zoom_speed * delta)

func _simple_pan(delta: float) -> void:
	var pan_vector := Vector2.ZERO
	
	if Input.is_action_pressed("camera_move_up"):
		pan_vector.y -= 1
	if Input.is_action_pressed("camera_move_down"):
		pan_vector.y += 1
	if Input.is_action_pressed("camera_move_left"):
		pan_vector.x -= 1
	if Input.is_action_pressed("camera_move_right"):
		pan_vector.x += 1
	
	pan_vector.normalized()
	position += pan_vector * delta * simple_pan_speed * (1/zoom.x)

func _click_and_drag() -> void:
	if !is_dragging and Input.is_action_just_pressed("camera_pan"):
		drag_start_mouse_pos = get_viewport().get_mouse_position()
		drag_start_camera_pos = position
		is_dragging = true
	
	if is_dragging and Input.is_action_just_released("camera_pan"):
		is_dragging = false
	
	if is_dragging:
		var move_vector = get_viewport().get_mouse_position() - drag_start_mouse_pos
		position = drag_start_camera_pos - move_vector * (1/zoom.x)
