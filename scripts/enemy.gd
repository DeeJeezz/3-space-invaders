class_name Enemy
extends Node2D

var ship: Ship
var hp: int


signal destroyed (enemy: Enemy)


func _ready() -> void:
	hp = ship.max_hp
	ship.hit.connect(_take_hit)


func shoot() -> void:
	ship.shoot()


func _take_hit() -> void:
	hp -= 1
	if hp <= 0:
		destroyed.emit(self)
		# Wait until destroy animation finished.
		await ship.destroy()
		queue_free()
