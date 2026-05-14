class_name FlickeringSprite
extends Sprite2D

@export var flickering_speed: float = 3.0
@export var flicker_times: int = 5
@export var target_color: Color

var _flicker: bool = false
var _original_color: Color
var _target_color: Color
var _flicker_times: int


func _ready() -> void:
	_original_color = modulate
	_target_color = target_color


func flicker() -> void:
	_flicker = true
	_flicker_times = flicker_times


func _process(delta: float) -> void:
	if not _flicker:
		return
		
	if _flicker_times <= 0:
		return

	modulate.r = move_toward(modulate.r, _target_color.r, flickering_speed * delta)
	modulate.g = move_toward(modulate.g, _target_color.g, flickering_speed * delta)
	modulate.b = move_toward(modulate.b, _target_color.b, flickering_speed * delta)
	modulate.a = move_toward(modulate.a, _target_color.a, flickering_speed * delta)
	if modulate == target_color:
		_target_color = _original_color
	elif modulate == _original_color:
		_target_color = target_color
		_flicker_times -= 1
