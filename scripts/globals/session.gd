extends Node


var chosen_ship: Constants.ShipType

#region AudioOptions
var volume: float = 50
var selected_output_device: String
#endregion
#region VideoOptions
var selected_display: int = 0
#endregion


func serialize() -> Dictionary:
	return {
		"options": {
			"audio": {
				"volume": volume,
				"output_device": selected_output_device,
			},
			"video": {
				"display": selected_display,
			}
		}
	}
