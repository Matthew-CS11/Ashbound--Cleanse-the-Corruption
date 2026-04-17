extends Node3D

@export var enemy_scene : PackedScene

var spawn_points: Array[Node] = []

func spawn_enemy(spawn_point : Marker3D) -> void:
	var enemy_instance = enemy_scene.instantiate()
	
	get_tree().current_scene.add_child.call_deferred(enemy_instance)
	enemy_instance.set_deferred("global_transform", spawn_point.global_transform)
	#enemy_instance.call_deferred("connect", "killed", Callable(self, "_on_enemy_killed"))
	
func spawn_all() -> void:
	for spawn_point in spawn_points:
		spawn_enemy(spawn_point)


func _on_boss_area_body_entered(body: Node3D) -> void:
	if body is Player:
		print("super goth mommy")
		spawn_all()
