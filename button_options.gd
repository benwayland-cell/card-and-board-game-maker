extends Node

# All functions here are things that can be in right click menus
# All functions shouls return a bool value
# true if the menu should close after executing
# false if the menu shouldn't close after executing

func test1(_given_node: Node) -> bool:
	print("test 1")
	return false

func test2(_given_node: Node) -> bool:
	print("test 2")
	return false

func test3(_given_node: Node) -> bool:
	print("test 3")
	return true

func flip_card(given_node: Card) -> bool:
	given_node.flip_card()
	return true
