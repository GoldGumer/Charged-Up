class_name Unit

extends StaticBody2D

@export var max_health : float
var current_health : float:
	set(value):
		current_health = value
		if current_health > max_health:
			current_health = max_health
		elif current_health <= 0:
			queue_free()
		print(current_health)
@export var attack_damage : float

func _ready():
	current_health = max_health

func receive_damage(_damage):
	current_health -= _damage

func heal_self(healing):
	current_health += healing
