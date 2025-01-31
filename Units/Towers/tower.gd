class_name Tower

extends Unit

# Money variables
@export var money_cost : int

# Energy variables
@export var energy_generation : int

# Attacking variables
@export var tower_attack : Resource
@export var attack_timer : Timer
var is_attack_ready : bool = false
var enemies_in_range = []

# Inherited Methods

func _physics_process(_delta: float):
	if is_attack_ready:
		attack()

# Signals

func _on_range_body_entered(_body: Node2D) -> void:
	enemy_entered_range(_body)

func _on_range_body_exited(_body: Node2D) -> void:
	enemy_exited_range(_body)

func _on_attack_timer_timeout() -> void:
	is_attack_ready = true

# Unique Methods

func enemy_entered_range(_body : Node2D):
	for group in _body.get_groups():
		if str(group) == "Enemy":
			enemies_in_range.append(_body)

func enemy_exited_range(_body: Node2D):
	var index = enemies_in_range.find(_body)
	if index != -1:
		enemies_in_range.pop_at(index)

func pre_attack():
	pass

func main_attack():
	var new_tower_attack = create_object(tower_attack)
	new_tower_attack.damage = attack_damage
	new_tower_attack.transform = new_tower_attack.transform.looking_at(enemies_in_range.front().transform.origin).rotated(1.570796)
	new_tower_attack.transform.origin = transform.origin
	is_attack_ready = false
	attack_timer.start()

func post_attack():
	pass

func attack():
	if enemies_in_range.size() > 0:
		pre_attack()
		main_attack()
		post_attack()

func die():
	queue_free()
