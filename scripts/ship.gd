class_name Ship
extends Node2D

const WALL_OFFSET: float = 5

@export_category("Settings")
## Ship movement speed.
@export var speed: float = 450.0
@export var hp: int = 4

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
	Signals.enemy_destroyed.emit()
	var timer: SceneTreeTimer = get_tree().create_timer(1)
	timer.timeout.connect(get_parent().queue_free)


## Call when ship should take hit.
func take_hit() -> void:
	hp -= 1
	_take_hit()
	if hp <= 0:
		destroy()


func _take_hit() -> void:
	ship_sprite.flicker()


func _clamp_position() -> void:
	global_position.x = clamp(global_position.x, _border_offset, _screen_size.x - _border_offset)


func _on_hurt_box_area_entered(area: Area2D) -> void:
	print('got hit')
	if area is Bullet:
		area.queue_free()
		take_hit()
