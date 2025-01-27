class_name Projectile

extends StaticBody2D

@export var speed : float
@export var damage : float

func _physics_process(delta : float):
	move_forward(delta)

func move_forward(delta : float):
	var collision = move_and_collide(-transform.y * speed * delta, false, 0.08, false)
	if collision != null:
		collision.get_collider().call("receive_damage", damage)
		queue_free()
