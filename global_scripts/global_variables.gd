extends Node

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()

const CARD_SCENE :PackedScene= preload("res://card_scene/card.tscn")
const RIGHT_CLICK_MENU_SCENE :PackedScene= preload("res://right_click_menu/right_click_menu.tscn")

func _ready():
	# init simple_label_settings
	simple_label_settings.font_size = 20
	simple_label_settings.font_color = Color.BLACK
