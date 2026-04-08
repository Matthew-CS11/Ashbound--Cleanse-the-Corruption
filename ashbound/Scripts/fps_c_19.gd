
extends Node3D

@export var range: float = 1000.0
@export var damage: int = 25

@export var mag_size: int = 12
@export var starting_mag_ammo: int = 6
@export var starting_reserve_ammo: int = 18
@export var max_reserve: int = 36

@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var ui: UI = $"../../../../UI"


var current_ammo: int
var reserve_ammo: int
var is_reloading: bool = false

func _ready() -> void:
	current_ammo = clamp(starting_mag_ammo, 0, mag_size)
	reserve_ammo = clamp(starting_reserve_ammo, 0, max_reserve)
	ui.update_ammo_label(current_ammo, reserve_ammo)


func can_shoot() -> bool:
	return current_ammo > 0 and not is_reloading
	
func shoot() -> void:
	if is_reloading:
		return

	if current_ammo <= 0:
		print("Empty magazine – reload!")
		return

	if camera == null:
		return

	current_ammo -= 1
	ui.update_ammo_label(current_ammo, reserve_ammo)
	

	var from: Vector3 = camera.global_position
	var to: Vector3 = from + (-camera.global_transform.basis.z * range)

	var exclude: Array = []
	if player != null:
		exclude.append(player)

	var space_state := get_world_3d().direct_space_state

	for i in range(10):
		var query := PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_bodies = true
		query.collide_with_areas = true
		query.exclude = exclude

		var hit := space_state.intersect_ray(query)
		if hit.is_empty():
			return

		var collider = hit.get("collider")
		if collider == null:
			return

		if collider is Area3D and collider.is_in_group("damage_area"):
			var enemy = collider.get_parent()
			if enemy and enemy.has_method("take_damage"):
				enemy.take_damage(damage)
			return

		if collider.has_method("take_damage"):
			collider.take_damage(damage)
			return

		exclude.append(collider)

func reload() -> void:
	if reserve_ammo > 0:
		if is_reloading:
			return

		if current_ammo == mag_size:
			return
		if reserve_ammo <= 0:
			print("No reserve ammo!")
			return

		is_reloading = true
	else:
		print("you broke")

	# Optional: wait for reload animation
	# await get_tree().create_timer(1.2).timeout

func add_reserve_ammo(amount: int) -> void:
	reserve_ammo = clamp(reserve_ammo + amount, 0, max_reserve)
	#print("Picked up ammo. Reserve:", reserve_ammo)
