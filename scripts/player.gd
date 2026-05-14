class_name Player
extends Node2D

var ship: Ship
var hp: int = 3


func _ready() -> void:
	var ship_scene_path: String = Constants.PLAYER_SHIPS_SCENES[Session.chosen_ship]
	var ship_scene: PackedScene = load(ship_scene_path)
	ship = ship_scene.instantiate()
	add_child(ship)


func _process(delta: float) -> void:
	_handle_input(delta)


func _handle_input(delta: float) -> void:
	var move_direction: float = Input.get_axis("move_left", "move_right")
	if move_direction:
		ship.move(move_direction, delta)

	if Input.is_action_pressed("shoot"):
		ship.shoot()
