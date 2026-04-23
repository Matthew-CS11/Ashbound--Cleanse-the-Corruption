extends Node3D

@export var enemy_scene : PackedScene
@onready var spawn_timer: Timer = $SpawnTimer

var spawn_points: Array[Node] = []

func _ready() -> void:
	for child in get_children():
		if child is Marker3D and child.is_in_group("spawn_points"):
			spawn_points.append(child)

func spawn_enemy(spawn_point : Marker3D) -> void:
	var enemy_instance = enemy_scene.instantiate()
	get_tree().current_scene.add_child(enemy_instance)
	enemy_instance.global_transform = spawn_point.global_transform
	
func spawn_all() -> void:
	for spawn_point in spawn_points:
		print('super duper goth mommy')
		spawn_enemy(spawn_point)

func _on_boss_area_body_entered(body: Node3D) -> void:
	if body is Player:
		print("super goth mommy")
		spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	spawn_all()
