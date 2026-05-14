class_name Enemy
extends Node2D

@export var minimum_fire_cooldown: float = 3.0
@export var maximum_fire_cooldown: float = 8.0
@export var shoot_timer: Timer

var ship: Ship
var can_shoot: bool = false


func _ready() -> void:
	shoot_timer.timeout.connect(shoot)
	if can_shoot:
		shoot_timer.start(randf_range(minimum_fire_cooldown, maximum_fire_cooldown))


func shoot() -> void:
	ship.shoot()
	shoot_timer.start(randf_range(minimum_fire_cooldown, maximum_fire_cooldown))
