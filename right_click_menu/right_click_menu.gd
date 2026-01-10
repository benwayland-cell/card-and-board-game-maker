extends Control

class_name RightClickMenu

var mouse_is_hovering := false

func _ready() -> void:
	CustomButton.new().setup("Test 1", ButtonOptions.test1, %VBoxContainer)
	CustomButton.new().setup("Test 2", ButtonOptions.test2, %VBoxContainer)
	CustomButton.new().setup("Test 3", ButtonOptions.test3, %VBoxContainer)
	
	pass
	# every button needs mouse_filter set to pass

func setup(button_actions : Array[Callable]):
	for button_action in button_actions:
		pass

func _process(_delta: float) -> void:
	if (
		(Input.is_action_just_pressed("left_click") and not mouse_is_hovering) or
		Input.is_action_just_pressed("right_click")
		):
		queue_free()


func _on_mouse_entered() -> void:
	mouse_is_hovering = true

func _on_mouse_exited() -> void:
	mouse_is_hovering = false
