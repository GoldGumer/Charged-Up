class_name Enemy

extends Unit

@export var speed : float
@export var target : Node2D
@export var nav_agent : NavigationAgent2D

var next_direction_movement : Vector2

func _ready() -> void:
	next_direction_movement = Vector2.ZERO

func _physics_process(_delta : float):
	move(_delta)

func move(_delta : float):
	next_direction_movement = -nav_agent.get_next_path_position().normalized()
	var collision = move_and_collide( next_direction_movement * speed * _delta, false, 0.08, false)
	if collision != null:
		var groups = collision.get_collider().call("get_groups")
		for group in groups:
			if str(group) == "Tower":
				collision.get_collider().call("receive_damage", attack_damage)
				queue_free()

func recalculate_path():
	nav_agent.target_position = target.position

func _on_navigation_agent_target_reached() -> void:
	recalculate_path()


func _on_navigation_agent_path_changed() -> void:
	recalculate_path()


func _on_navigation_agent_link_reached(details: Dictionary) -> void:
	recalculate_path()
