class_name Tower

extends Unit

enum energy_type { blue, red, green }

# Money variables
@export var money_cost : int

# Energy variables
@export var energy_cost : int
var energy_generation : int
@export var energy_source : energy_type
@export var energy_per_resource : int


# Attacking variables
@export var bullet : Resource
@export var attack_timer : Timer
var is_attack_ready : bool = false
var enemies_in_range = []

func _physics_process(_delta: float):
	if is_attack_ready:
		attack()

func _on_range_body_entered(_body: Node2D) -> void:
	for group in _body.get_groups():
		if str(group) == "Enemy":
			enemies_in_range.append(_body)

func _on_range_body_exited(_body: Node2D) -> void:
	var index = enemies_in_range.find(_body)
	if index != -1:
		enemies_in_range.pop_at(index)

func _on_attack_timer_timeout() -> void:
	is_attack_ready = true

func attack():
	if enemies_in_range.size() > 0:
		var new_bullet = create_object(bullet)
		new_bullet.damage = attack_damage
		new_bullet.transform = new_bullet.transform.looking_at(enemies_in_range.front().transform.origin).rotated(1.570796)
		new_bullet.transform.origin = transform.origin
		is_attack_ready = false
		attack_timer.start()

func die():
	print("dead")
