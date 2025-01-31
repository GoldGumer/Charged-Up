extends Tower

func main_attack():
	var new_tower_attack = create_object(tower_attack)
	new_tower_attack.damage = attack_damage
	new_tower_attack.target = enemies_in_range.front()
	new_tower_attack.transform.origin = enemies_in_range.front().transform.origin
	new_tower_attack.attack()
	is_attack_ready = false
	attack_timer.start()
