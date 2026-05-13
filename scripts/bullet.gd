class_name Bullet
extends RigidBody2D

const DIRECTION: Vector2 = Vector2.UP

var speed: float = 500.0


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(DIRECTION * speed * delta)
	if collision:
		var hit_object: Object = collision.get_collider()
		if hit_object is Ship:
			hit_object.take_hit()
		queue_free()
		
	if position.y < 0:
		queue_free()
		
