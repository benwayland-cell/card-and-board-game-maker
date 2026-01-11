extends Node

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()


func _ready():
	# init simple_label_settings
	simple_label_settings.font_size = 20
	simple_label_settings.font_color = Color.BLACK
