extends Instant

@export var chain_index : int = 2
var is_duplicated := false

func _on_timer_timeout() -> void:
	queue_free()

func _on_chain_lightning_area_body_entered(body: Node2D) -> void:
	if chain_index >= 1 and body != target and not is_duplicated:
			var new_lightning = self.duplicate()
			owner.call_deferred("add_child", new_lightning)
			new_lightning.set_deferred("owner", owner)
			new_lightning.set_deferred("damage", damage)
			new_lightning.find_child("Timer").call_deferred("start")
			new_lightning.set_deferred("chain_index", chain_index - 1)
			new_lightning.set_deferred("target", body)
			new_lightning.transform.origin = body.transform.origin
			new_lightning.call_deferred("attack")
			is_duplicated = true
