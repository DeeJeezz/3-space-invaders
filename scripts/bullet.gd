class_name Bullet
extends Area2D


var _direction: Vector2 = Vector2.ZERO

var speed: float = 500.0


func _ready() -> void:
	monitoring = false


func shoot(direction: Vector2) -> void:
	_direction = direction


func _physics_process(delta: float) -> void:
	position += _direction * speed * delta

	if position.y < 0 or position.y > 4000.0:
		queue_free()
