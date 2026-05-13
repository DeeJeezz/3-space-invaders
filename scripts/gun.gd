class_name Gun
extends Node2D

@export_category("Gun")
## Bullet scene to spawn.
@export var bullet_scene: PackedScene
## At this points bullets will be spawned.
@export var bullet_spawn_markers: Array[Marker2D]
## Cooldown [i](in seconds)[/i] between shots.
@export var fire_cooldown: float = 0.25
## Bullet movement speed.
@export var bullet_speed: float = 500.0

var _can_shoot: bool = true


## Shoots [param bullet_scene] with [param bullet_speed] at [param bullet_spawn_markers] positions.
func shoot() -> void:
	if not _can_shoot:
		return

	for bullet_spawn_marker in bullet_spawn_markers:
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.global_position = bullet_spawn_marker.global_position
		bullet.speed = bullet_speed
		get_tree().root.add_child(bullet)
	_can_shoot = false
	var shoot_timer: SceneTreeTimer = get_tree().create_timer(fire_cooldown)
	shoot_timer.timeout.connect(func(): _can_shoot = true)
