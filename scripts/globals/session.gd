extends Node

var chosen_ship: Constants.ShipType

#region AudioOptions
var volume: float = 50
var selected_output_device: String
#endregion

#region VideoOptions
var selected_display: int = 0
var selected_resolution: Vector2 = Constants.AVAILABLE_RESOLUTIONS[0]

#endregion


func apply_options() -> void:
	var master_bus_index: int = AudioServer.get_bus_index("Master")
	AudioServer.output_device = selected_output_device
	AudioServer.set_bus_volume_linear(master_bus_index, Session.volume)
	DisplayServer.window_set_current_screen(Session.selected_display)
	DisplayServer.window_set_size(Session.selected_resolution)


func serialize() -> Dictionary:
	return {
		"options": {
			"audio": {
				"volume": volume,
				"output_device": selected_output_device,
			} ,
			"video": {
				"display": selected_display,
				"resolution": [selected_resolution.x, selected_resolution.y]
			}
		}
	}
	
	
func deserialize(session_data: Dictionary) -> void:
	if not session_data:
		return
	var audio_settings: Dictionary = session_data["options"]["audio"]
	volume = audio_settings["volume"]
	selected_output_device = audio_settings["output_device"]
	
	var video_settings: Dictionary = session_data["options"]["video"]
	selected_display = video_settings["display"]
	selected_resolution = Vector2(video_settings["resolution"][0], video_settings["resolution"][1])


func save_session() -> void:
	SaveManager.save_current_session(serialize())


func load_session() -> void:
	var last_session: Dictionary = SaveManager.load_last_session()
	deserialize(last_session)
