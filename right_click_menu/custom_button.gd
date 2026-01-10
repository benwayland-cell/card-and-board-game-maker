extends Button

class_name CustomButton

var function :Callable

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS

func setup(new_text: String, given_function: Callable, node_to_be_attatched_to: Node):
	text = new_text
	function = given_function
	self.pressed.connect(self._on_pressed)
	node_to_be_attatched_to.add_child(self)


func _on_pressed() -> void:
	function.call()
