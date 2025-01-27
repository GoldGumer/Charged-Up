class_name Tower

extends Unit

@export var money_cost : int
@export var upfront_energy_cost : int
@export var reoccuring_energy_cost : int

@export var bullet : Resource

var enemies_in_range = []

func _on_range_body_entered(body: Node2D) -> void:
	for group in body.get_groups():
		if str(group) == "Enemy":
			enemies_in_range.append(body)

func _on_range_body_exited(body: Node2D) -> void:
	var index = enemies_in_range.find(body)
	if index != -1:
		enemies_in_range.pop_at(index)

func _on_attack_timer_timeout() -> void:
	if enemies_in_range.size() > 0:
		var new_bullet = bullet.instantiate()
		owner.add_child(new_bullet)
		new_bullet.transform.origin = transform.origin
		new_bullet.transform = new_bullet.transform.looking_at(enemies_in_range.front().transform.origin).rotated(1.570796)
		new_bullet.transform.origin = transform.origin
