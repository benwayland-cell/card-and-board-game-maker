extends Area2D

func check_for_snapping() -> bool:
	return get_parent().get_mouse_is_overlapping()
