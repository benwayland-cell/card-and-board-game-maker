extends Node2D

#enum Menus {MAIN, CARD_TYPE, CARD_SUB_TYPE}
#var current_menu := Menus.MAIN

func _ready() -> void:
	#%CardBackground.texture = GlobalVariables.TEST_CARD_FRONT_TEXTURE
	%MainMenu.open()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		get_tree().change_scene_to_file("res://table/table.tscn")
