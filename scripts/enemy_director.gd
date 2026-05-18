class_name EnemyDirector
extends Node2D

@export_category("Shooting settings")
@export var shoot_timer: Timer
@export var minimun_fire_cooldown: float = 5.0
@export var maximum_fire_cooldown: float = 10.0
@export var maximum_firing_enemies: int = 1
@export_group("Simultaneously shooting settings")
@export var minimum_sim_fire_cooldown: float = 0.5
@export var maximum_sim_fire_cooldown: float = 1

@export_category("Moving settings")
@export var move_timer: Timer
@export var minimum_move_cooldown: float = 3.0
@export var maximum_move_cooldown: float = 7.0
@export var move_step: Vector2 = Vector2(100, 0)

@export_category("Spawn settings")
@export var rows: int = 1
@export var cols: int = 12
@export var start_point: Marker2D
@export var spawn_offset: Vector2 = Vector2(80, 60)

var enemy_scene: PackedScene = preload(Constants.ENEMY_SCENE_PATH)
var enemies: Dictionary[int, Enemy]

var _screen_size: Vector2
var _move_direction: Vector2 = Vector2.RIGHT

signal all_enemies_destroyed


func start() -> void:
	randomize()

	_screen_size = get_viewport_rect().size

	# Spawnin enemies.
	_spawn_enemies()

	# Connecting director signals.
	shoot_timer.timeout.connect(_shoot)
	move_timer.timeout.connect(_move)

	# Initial setup timers.
	_start_shoot_timer()
	_start_move_timer()


func _shoot() -> void:
	if not enemies:
		return
	# Define how many enemies will shoot at this moment.
	var sim_enemies: int = randi_range(1, maximum_firing_enemies)
	# Delay between enemies shots if there are multiple enemies shooting at this moment.
	var sim_fire_time: float = 0.0
	if sim_enemies > 1:
		# Set small delay between shots.
		sim_fire_time = randf_range(minimum_sim_fire_cooldown, maximum_sim_fire_cooldown)

	# Enemies shooting.
	for i in range(sim_enemies):
		var enemy: Enemy = enemies.values().pick_random()
		if i > 0:
			await get_tree().create_timer(sim_fire_time).timeout
		if not is_instance_valid(enemy):
			continue
		enemy.shoot()
	# Reset shoot timer.
	_start_shoot_timer()


func _move() -> void:
	if not enemies:
		return
	
	var _move_step: Vector2 = move_step

	if _move_direction == Vector2.LEFT:
		_move_step *= 2

	start_point.position += move_step.rotated(_move_step.angle_to(_move_direction))

	if _move_direction == Vector2.RIGHT:
		_move_direction = Vector2.DOWN
	elif _move_direction == Vector2.DOWN:
		_move_direction = Vector2.LEFT
	elif _move_direction == Vector2.LEFT:
		_move_direction = Vector2.UP
	elif _move_direction == Vector2.UP:
		_move_direction = Vector2.RIGHT

	_start_move_timer()


func _spawn_enemies() -> void:
	for row in range(rows):
		for col in range(cols):
			# Create enemy instance.
			var enemy: Enemy = enemy_scene.instantiate()
			# Create ship instance.
			var ship_scene: PackedScene = load(Constants.ENEMY_SHIPS_SCENES[Constants.ENEMIES_SHIP_TYPES.pick_random()])
			var ship: Ship = ship_scene.instantiate()
			# Setup ship.
			ship.rotation_degrees = 180
			# Setup enemy.
			enemy.position = start_point.position + spawn_offset * Vector2(col, row)
			enemy.ship = ship
			enemy.add_child(ship)

			# Connect "destroyed" signal to the director.
			enemy.destroyed.connect(_on_enemy_destroyed)

			start_point.add_child(enemy)
			enemies[enemy.get_instance_id()] = enemy


func _on_enemy_destroyed(enemy: Enemy) -> void:
	Signals.add_score.emit(enemy.ship.score_for_destroy)
	# Remove enemy from array to avoid "freed instance" error.
	enemies.erase(enemy.get_instance_id())
	if not enemies:
		shoot_timer.stop()
		move_timer.stop()
		all_enemies_destroyed.emit()


func _start_shoot_timer() -> void:
	shoot_timer.start(randf_range(minimun_fire_cooldown, maximum_fire_cooldown))


func _start_move_timer() -> void:
	move_timer.start(randf_range(minimum_move_cooldown, maximum_move_cooldown))
