class_name CustomButton

extends Button

signal cancel_menu

var function :Callable
var parent_node :Node


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS


func _init(given_node: Node, new_text: String, given_function: Callable) -> void:
	text = new_text
	function = given_function
	parent_node = given_node
	self.pressed.connect(self._on_pressed)


func _on_pressed() -> void:
	# run the function for this button and check if we should cancel the right click menu
	if function.call(parent_node):
		# cancel the right click menu
		cancel_menu.emit()
