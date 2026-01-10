extends Button

class_name CustomButton

var function :Callable

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS

func setup(given_function: Callable):
	function = given_function

func _on_pressed() -> void:
	function.call()
