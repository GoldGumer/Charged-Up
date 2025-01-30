extends Node2D

@export var round_max_time : float

@export var enemies_to_spawn : int
var enemies_spawned : int = 0
@export var enemy_type : Resource

@export var spawn_area : Area2D
@export var timer : Timer

var is_spawning : bool = true

func calculate_timer():
	timer.wait_time = round_max_time / float(enemies_to_spawn)
	timer.start()

func _on_timer_timeout():
	if is_spawning and enemies_spawned < enemies_to_spawn:
		enemies_spawned += 1
		var new_enemy = enemy_type.instantiate()
		owner.add_child(new_enemy)
		new_enemy.owner = owner
		new_enemy.transform.origin = transform.origin
		if spawn_area.get_child(0).shape is CircleShape2D:
			var offset := Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0)).normalized() * randf_range(0.0, spawn_area.get_child(0).shape.radius)
			new_enemy.transform.origin += offset
		timer.start()


func _ready():
	calculate_timer()
