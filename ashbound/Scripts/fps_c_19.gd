extends Node3D

@export var range: float = 1000.0
@export var damage: int = 25
@export var starting_ammo : int = 6


@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var player: Player = get_tree().get_first_node_in_group("Player")

var current_ammo : int
var reserve_ammo: int
var max_reserve : int = 36
var mag_size : int = 12

func _ready() -> void:
	current_ammo = starting_ammo
	
func shoot() -> void:
	if camera == null:
		return
		
	var from: Vector3 = camera.global_position
	var to: Vector3 = from + (-camera.global_transform.basis.z * range)
	
	var exclude: Array = []
	
	if current_ammo >0:
		current_ammo -=1
	else:
		print('no ammo')
	
	if player != null:
		exclude.append(player)
		
	var space_state := get_world_3d().direct_space_state
	
	for i in range(10):
		var query := PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_bodies = true
		query.collide_with_areas = true
		query.exclude = exclude
		
		var hit: Dictionary = space_state.intersect_ray(query)
		
		if hit.is_empty():
			return
			
		var collider: Object = hit.get("collider")
		
		if collider == null:
			return
			
		if collider is Area3D:
			var area: Area3D = collider
			
			if area.is_in_group("damage_area"):
				var enemy: Node = area.get_parent()
				if enemy != null and enemy.has_method("take_damage"):
					enemy.take_damage(damage)
				return
				
			exclude.append(area)
			continue
			
		if collider is Node and collider.has_method("take_damage"):
			collider.take_damage(damage)
			return
			
		if collider is CollisionObject3D:
			exclude.append(collider)
			
		else:
			return
