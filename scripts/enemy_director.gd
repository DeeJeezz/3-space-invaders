class_name EnemyDirector
extends Node2D


@export var ship_scenes: Array[PackedScene]


func _ready() -> void:
	spawn_enemies()


func spawn_enemies() -> void:
	var ship_scene: PackedScene = ship_scenes.pick_random()
	var ship: Ship = ship_scene.instantiate()
	ship.position = Vector2(100, 100)
	ship.rotation_degrees = 180
	add_child(ship)
