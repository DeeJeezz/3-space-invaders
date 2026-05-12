extends Node2D
class_name Ship

@export_category("Settings")
## Ship movement speed.
@export var speed: float = 450.0

@export_category("Gun")
## Cooldown [i](in seconds)[/i] between shots.
@export var fire_cooldown: float = 0.25
@export var bullet_scene: PackedScene

@export_category("Nodes")
@export var ship_sprite: Sprite2D
@export var bullet_spawn_markers: Array[Marker2D]

const WALL_OFFSET: float = 5
var _screen_size: Vector2
var _border_offset: float

var _can_shoot: bool = true


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	var ship_size: Vector2 = ship_sprite.region_rect.size * ship_sprite.scale
	_border_offset = WALL_OFFSET + (ship_size.x / 2)


func _clamp_position() -> void:
	global_position.x = clamp(global_position.x, _border_offset, _screen_size.x - _border_offset)


func move(direction: float, delta: float) -> void:
	global_position.x += direction * speed * delta
	_clamp_position()


func shoot() -> void:
	if not _can_shoot:
		return

	for bullet_spawn_marker in bullet_spawn_markers:
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.global_position = bullet_spawn_marker.global_position
		get_tree().root.add_child(bullet)
	_can_shoot = false
	var shoot_timer: SceneTreeTimer = get_tree().create_timer(fire_cooldown)
	shoot_timer.timeout.connect(func(): _can_shoot = true)
