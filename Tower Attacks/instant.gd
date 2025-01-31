class_name Instant

extends Sprite2D

var target : Node2D
var damage : float:
	set(_value):
		damage = _value

func attack():
	if target.has_method("receive_damage"):
		target.call("receive_damage", damage)
