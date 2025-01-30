extends Node2D

@export var buildable_tower = Array()
var tower_index := -1
var pressed := false
var is_planning := false


func _process(_delta: float):
	if is_planning and tower_index != -1:
		if Input.is_mouse_button_pressed(1):
			build_tower(buildable_tower[tower_index], Vector2(24 * (floor(get_global_mouse_position().x / 24.0)) + 12.0, 24 * (floor(get_global_mouse_position().y / 24.0)) + 12.0))
		else:
			build_planning(buildable_tower[tower_index], Vector2(24 * (floor(get_global_mouse_position().x / 24.0)) + 12.0, 24 * (floor(get_global_mouse_position().y / 24.0)) + 12.0))
	
	if Input.is_key_pressed(KEY_Q) and not pressed:
		tower_index = 0
		is_planning = true
		pressed = true
	elif not Input.is_key_pressed(KEY_Q):
		pressed = false

func build_planning(_tower : Resource, _position : Vector2):
	var has_sprite := false
	for planner_child in get_children():
		if planner_child is Sprite2D:
			planner_child.transform.origin = _position
			has_sprite = true
	if not has_sprite:
		var sprite
		var temp_tower = _tower.instantiate()
		for tower_child in temp_tower.get_children():
			if tower_child is Sprite2D:
				sprite = tower_child.duplicate()
		add_child(sprite)
		sprite.modulate.a = 0.5
		sprite.transform.origin = _position
		temp_tower.queue_free()
		print("Naurr!")

func build_tower(_tower : Resource, _position : Vector2):
	var new_tower = _tower.instantiate()
	owner.add_child(new_tower)
	new_tower.owner = owner
	new_tower.transform.origin = _position
	
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.call("find_target")
	
	is_planning = false
	tower_index = -1
