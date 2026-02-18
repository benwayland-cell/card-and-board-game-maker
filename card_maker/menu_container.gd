extends MarginContainer

const DEFAULT_MENU: PackedScene= GlobalVariables.MAIN_MENU_SCENE
var current_menu: CardMakerMenu

func _ready() -> void:
	print(GlobalVariables.MAIN_MENU_SCENE)
	var default_menu: CardMakerMenu= DEFAULT_MENU.instantiate()
	add_child(default_menu)
	current_menu = default_menu
	connect_current_menu()
	default_menu.setup_main_menu()


func connect_current_menu() -> void:
	current_menu.connect_to_new_menu.connect(_on_connect_to_new_menu)
	current_menu.change_menu_name.connect(_on_change_menu_name)
	current_menu.change_card_background.connect(_on_change_card_background)


func _on_connect_to_new_menu(new_menu: CardMakerMenu) -> void:
	current_menu = new_menu
	connect_current_menu()


func _on_change_menu_name(new_text: String) -> void:
	%MenuName.text = new_text


func _on_change_card_background(new_texture: Texture2D) -> void:
	%CardBackground.texture = new_texture


func _on_back_button_pressed() -> void:
	current_menu.on_back_button_pressed()
