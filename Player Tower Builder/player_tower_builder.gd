extends Node2D

@export var buildable_tower = Array()
var tower_index := -1
var pressed := false
var is_planning := false

const GRID_SIZE := 32.0

var key_input_towers = {
	KEY_Q : 0,
	KEY_W : 1
}

func _process(_delta: float):
	var grid_position = Vector2(
	GRID_SIZE * (floor(get_global_mouse_position().x / GRID_SIZE)) + (GRID_SIZE / 2),
	GRID_SIZE * (floor(get_global_mouse_position().y / GRID_SIZE)) + (GRID_SIZE / 2)
	)
	
	if is_planning and tower_index != -1:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			build_tower(buildable_tower[tower_index], grid_position)
		else:
			build_planning(buildable_tower[tower_index], grid_position)
	
	for key in key_input_towers:
		if Input.is_key_pressed(key) and not pressed:
			tower_index = key_input_towers[key]
			clear_sprites()
			is_planning = true
			pressed = true
	
	for key in key_input_towers:
		if not Input.is_key_pressed(key):
			pressed = false

func build_planning(_tower : Resource, _position : Vector2):
	var has_sprite := false
	for planner_child in get_children():
		if planner_child is Sprite2D or planner_child is AnimatedSprite2D:
			planner_child.transform.origin = _position
			has_sprite = true
	if not has_sprite:
		var tower_sprites : Array
		var temp_tower = _tower.instantiate()
		for tower_child in temp_tower.get_children():
			if tower_child is Sprite2D or tower_child is AnimatedSprite2D:
				tower_sprites.append(tower_child.duplicate())
		for sprite in tower_sprites:
			add_child(sprite)
			sprite.modulate.a = 0.5
			sprite.transform.origin = _position
		temp_tower.queue_free()

func build_tower(_tower : Resource, _position : Vector2):
	var new_tower = _tower.instantiate()
	owner.add_child(new_tower)
	new_tower.owner = owner
	new_tower.transform.origin = _position
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.call("find_target")
	clear_sprites()
	is_planning = false
	tower_index = -1

func clear_sprites():
	for planner_child in get_children():
		if planner_child is Sprite2D or planner_child is AnimatedSprite2D:
			planner_child.queue_free()
