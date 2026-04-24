extends Node3D

@export var enemy_scene : PackedScene
@export var spawn_delay := 15.0
@export var max_alive_enemies := 4

var spawn_points: Array[Node] = []
var alive_enemies := 0
var spawned_count := 0
var spawning_active := false

func _ready() -> void:
	for child in get_children():
		if child is Marker3D and child.is_in_group("spawn_points"):
			spawn_points.append(child)

func start_spawning() -> void:
	if spawning_active:
		return
	spawning_active = true
	spawn_loop()

func spawn_loop() -> void:
	while spawning_active:
		if alive_enemies < max_alive_enemies:
			spawn_enemy()
			
		await get_tree().create_timer(spawn_delay).timeout

func spawn_enemy() -> void:
	var spawn_point: Marker3D = spawn_points.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	get_tree().current_scene.add_child(enemy_instance)
	enemy_instance.global_transform = spawn_point.global_transform
	
	alive_enemies += 1
	spawned_count += 1
	
	enemy_instance.killed.connect(_on_enemy_killed)

func _on_enemy_killed() -> void:
	alive_enemies -=1
	alive_enemies = max(alive_enemies, 0)

func _on_boss_area_body_entered(body: Node3D) -> void:
	if body is Player:
		print("super goth mommy")
		start_spawning()
