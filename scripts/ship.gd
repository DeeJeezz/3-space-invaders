class_name Ship
extends Node2D

signal hit

const WALL_OFFSET: float = 5

@export_category("Settings")
## Ship movement speed.
@export var speed: float = 450.0
@export var max_hp: int = 4
@export var score_for_destroy: int = 100

@export_category("Nodes")
@export var ship_sprite: FlickeringSprite
@export var gun: Gun
@export var explosion: AnimatedSprite2D
@export var hurt_box: Area2D

var _screen_size: Vector2
var _border_offset: float


func _ready() -> void:

	_screen_size = get_viewport_rect().size
	var ship_size: Vector2 = ship_sprite.region_rect.size * ship_sprite.scale
	_border_offset = WALL_OFFSET + (ship_size.x / 2)
	hurt_box.area_entered.connect(_on_hurt_box_area_entered)
	hurt_box.monitorable = false


## Moves ship toward [param direction] with [param speed]
func move(direction: float, delta: float) -> void:
	global_position.x += direction * speed * delta
	_clamp_position()


## Shoots from [param gun], if exists.
func shoot() -> void:
	if gun:
		gun.shoot(Vector2.UP.rotated(rotation))


## Destroy ship, play explosion animation.
func destroy() -> void:
	hurt_box.set_deferred("monitoring", false)
	ship_sprite.visible = false
	explosion.visible = true
	explosion.sprite_frames = load(Constants.EXPLOSIONS.pick_random())
	explosion.play()
	await explosion.animation_finished


func _get_configuration_warnings():
	var warnings = []
	if ship_sprite == null:
		warnings.append("Ship sprite must be set")
	if gun == null:
		warnings.append("Gun must be set")
	if explosion == null:
		warnings.append("Explosion must be set")
	if hurt_box == null:
		warnings.append("HurtBox must be set")
	return warnings


func _take_hit() -> void:
	hit.emit()
	ship_sprite.flicker()


func _clamp_position() -> void:
	global_position.x = clamp(global_position.x, _border_offset, _screen_size.x - _border_offset)


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
		_take_hit()
