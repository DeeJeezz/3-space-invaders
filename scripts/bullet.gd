extends RigidBody2D
class_name Bullet


const SPEED: float = 500.0
const DIRECTION: Vector2 = Vector2.UP


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(DIRECTION * SPEED * delta)
