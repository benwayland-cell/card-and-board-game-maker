extends Control

var mouse_is_hovering := false

func _ready() -> void:
	pass
	# every button needs mouse_input set to pass (1)

func _process(_delta: float) -> void:
	if (
		(Input.is_action_just_pressed("left_click") and not mouse_is_hovering) or
		Input.is_action_just_pressed("right_click")
		):
		queue_free()

func _on_test_button_1_pressed() -> void:
	print("test button 1")


func _on_test_button_2_pressed() -> void:
	print("Test button 2")


func _on_test_button_3_pressed() -> void:
	print("Test button 3")


func _on_mouse_entered() -> void:
	mouse_is_hovering = true

func _on_mouse_exited() -> void:
	mouse_is_hovering = false
