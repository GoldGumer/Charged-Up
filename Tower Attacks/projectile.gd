class_name Projectile

extends RigidBody2D

@export var speed : float
var damage : float:
	set(_value):
		damage = _value

func _physics_process(_delta : float):
	move_forward(_delta)

func move_forward(_delta : float):
	var collision = move_and_collide(-transform.y * speed * _delta, false, 0.08, false)
	if collision != null and collision.get_collider().has_method("receive_damage"):
		collision.get_collider().call("receive_damage", damage)
		queue_free()
