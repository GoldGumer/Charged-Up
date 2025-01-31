extends Tower

@export var barrel : AnimatedSprite2D

func pre_attack():
	rotate_barrel()

func rotate_barrel():
	barrel.transform = barrel.transform.looking_at(enemies_in_range.front().transform.origin).rotated(1.570796)
