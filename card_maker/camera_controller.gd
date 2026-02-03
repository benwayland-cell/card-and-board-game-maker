extends Camera2D

@export var zoom_factor := 0.1
@export var zoom_speed := 10

var zoom_target :Vector2

func _ready() -> void:
	zoom_target = zoom

#func _process(delta: float) -> void:
	#_zoom(delta)

func _zoom(delta: float) -> void:
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom_target *= 1 + zoom_factor
	
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom_target *= 1 - zoom_factor
	
	zoom = zoom.slerp(zoom_target, zoom_speed * delta)
