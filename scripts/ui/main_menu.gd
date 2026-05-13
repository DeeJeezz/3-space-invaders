extends CanvasLayer


func _on_start_game_button_button_down() -> void:
	get_tree().change_scene_to_file(Constants.CHOOSE_SHIP_SCENE_PATH)


func _on_options_button_button_down() -> void:
	get_tree().change_scene_to_file(Constants.OPTIONS_SCENE_PATH)


func _on_quit_game_button_button_down() -> void:
	get_tree().quit()
