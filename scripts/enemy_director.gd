class_name EnemyDirector
extends Node2D


@export var rows: int = 1
@export var cols: int = 12
@export var start_point: Marker2D


var enemy_scene: PackedScene = preload(Constants.ENEMY_SCENE_PATH)


func _ready() -> void:
	spawn_enemies()


func spawn_enemies() -> void:
	for row in range(rows):
		for col in range(cols):
			var enemy: Enemy = enemy_scene.instantiate()
			if row == rows - 1:
				enemy.can_shoot = true
			var ship_scene: PackedScene = load(Constants.ENEMY_SHIPS_SCENES[Constants.ENEMIES_SHIP_TYPES.pick_random()])
			var ship: Ship = ship_scene.instantiate()
			ship.rotation_degrees = 180
			enemy.position = start_point.position + Vector2(80 * col, 60 * row)
			enemy.ship = ship
			enemy.add_child(ship)
			add_child(enemy)
