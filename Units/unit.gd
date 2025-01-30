class_name Unit

extends RigidBody2D

@export var max_health : float
var current_health : float:
	set(_value):
		current_health = _value
		if current_health > max_health:
			current_health = max_health
		elif current_health <= 0:
			die()
@export var attack_damage : float

func _ready():
	current_health = max_health

func receive_damage(_damage):
	current_health -= _damage

func heal_self(_healing):
	current_health += _healing

func die():
	queue_free()

func create_object(_object : Resource):
	var new_object = _object.instantiate()
	owner.add_child(new_object)
	new_object.owner = owner
	new_object.transform.origin = transform.origin
	return new_object
