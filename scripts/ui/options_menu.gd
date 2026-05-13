extends CanvasLayer

@export_category("Audio")
@export var volume_slider: HSlider
@export var volume_value_label: Label
@export var output_device_option_button: OptionButton

@export_category("Video")
@export var resolution_option_button: OptionButton
@export var display_option_button: OptionButton


func _ready() -> void:
	_setup_controls()
	volume_value_label.text = "%d" % volume_slider.value


func _setup_controls() -> void:
	#region Audio
	volume_slider.value = Session.volume
	output_device_option_button.clear()
	for output_device in AudioServer.get_output_device_list():
		output_device_option_button.add_item(output_device)
	#endregion

	#region Video
	var screen_count: int = DisplayServer.get_screen_count()
	display_option_button.clear()
	for screen_index in range(screen_count):
		var display_resolution: Vector2 = DisplayServer.screen_get_size(screen_index)
		display_option_button.add_item("Display %d (%dx%d)" % [(screen_index + 1), display_resolution.x, display_resolution.y])
	if screen_count == 1:
		display_option_button.disabled = true
	#endregion


func _on_volume_h_slider_value_changed(value: float) -> void:
	volume_value_label.text = "%d" % value


func _on_back_button_button_down() -> void:
	get_tree().change_scene_to_file(Constants.MAIN_MENU_SCENE_PATH)


func _on_devices_option_button_item_selected(index: int) -> void:
	Session.selected_output_device = output_device_option_button.get_item_text(index)


func _on_display_option_button_item_selected(index: int) -> void:
	Session.selected_display = index
