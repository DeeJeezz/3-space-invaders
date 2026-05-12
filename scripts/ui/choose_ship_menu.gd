extends CanvasLayer


func _on_fregate_button_button_down() -> void:
	Session.chosen_ship = Constants.ShipType.FREGATE
	get_tree().change_scene_to_file(Constants.GAME_SCENE_PATH)


func _on_trooper_button_button_down() -> void:
	Session.chosen_ship = Constants.ShipType.TROOPER
	get_tree().change_scene_to_file(Constants.GAME_SCENE_PATH)
