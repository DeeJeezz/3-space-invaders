class_name Ship
extends RigidBody2D

const WALL_OFFSET: float = 5

@export_category("Settings")
## Ship movement speed.
@export var speed: float = 450.0

@export_category("Nodes")
@export var ship_sprite: Sprite2D
@export var gun: Gun
@export var explosion: AnimatedSprite2D

var _screen_size: Vector2
var _border_offset: float


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	var ship_size: Vector2 = ship_sprite.region_rect.size * ship_sprite.scale
	_border_offset = WALL_OFFSET + (ship_size.x / 2)


## Moves ship toward [param direction] with [param speed]
func move(direction: float, delta: float) -> void:
	global_position.x += direction * speed * delta
	_clamp_position()


## Shoots from [param gun], if exists.
func shoot() -> void:
	if gun:
		gun.shoot()


## Destroy ship, play explosion animation.
func destroy() -> void:
	ship_sprite.visible = false
	explosion.visible = true
	explosion.sprite_frames = load(Constants.EXPLOSIONS.pick_random())
	explosion.play()
	var timer: SceneTreeTimer = get_tree().create_timer(1)
	timer.timeout.connect(queue_free)
	


## Call when ship should take hit.
func take_hit() -> void:
	destroy()


func _clamp_position() -> void:
	global_position.x = clamp(global_position.x, _border_offset, _screen_size.x - _border_offset)
