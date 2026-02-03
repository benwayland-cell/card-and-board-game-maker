extends Node2D

#enum Menus {MAIN, CARD_TYPE, CARD_SUB_TYPE}
#var current_menu := Menus.MAIN

func _ready() -> void:
	%CardBackground.texture = GlobalVariables.TEST_CARD_FRONT_TEXTURE
	%MainMenu.open()
