class_name Enemy

extends Unit

@export var speed : float
var target : Node2D
@export var nav_agent : NavigationAgent2D

var next_direction_movement : Vector2

func _ready():
	next_direction_movement = Vector2.ZERO
	current_health = max_health
	find_target()

func _physics_process(_delta : float):
	move(_delta)

func move(_delta : float):
	next_direction_movement = to_local(nav_agent.get_next_path_position()).normalized()
	var collision = move_and_collide( next_direction_movement * speed * _delta, false, 0.08, false)
	if collision != null:
		var groups = collision.get_collider().call("get_groups")
		for group in groups:
			if str(group) == "Tower":
				collision.get_collider().call("receive_damage", attack_damage)
				queue_free()

func find_target():
	for tower in get_tree().get_nodes_in_group("Tower"):
		if target == null:
			target = tower
		elif tower.transform.origin.distance_to(transform.origin) < target.transform.origin.distance_to(transform.origin):
			target = tower
	recalculate_path()

func recalculate_path():
	if target != null:
		nav_agent.target_position = target.position
	else:
		nav_agent.target_position = Vector2.ZERO
