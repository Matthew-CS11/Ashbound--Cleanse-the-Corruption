extends Node3D

@onready var muzzle: Marker3D = $Sketchfab_model/b34e1f0b138c4750adf4ba8296639418_fbx/Object_2/RootNode/Object_4/BPpistol/base/Muzzle_Marker
@export var range: float = 100.0
@export var damage: int = 25
	
func shoot() -> void:
	var from = muzzle.global_position
	var to = from + (-muzzle.global_transform.basis.z) * range
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	
	query.exclude = [self, get_parent()]
	
	var hit = space_state.intersect_ray(query)
	
	if hit:
		handle_hit(hit)

func handle_hit(hit: Dictionary) -> void:
	var c = hit.collider
	
	if c is Area3D:
		var a := c as Area3D
		if a.is_in_group("damage_area"):
			var enemy = a.owner
			if enemy and enemy.has_method("take_damage"):
				enemy.take_damage(damage)
			return
			
	if c is Node and (c as Node).has_method("take_damage"):
		(c as Node).take_damage(damage)
		return
