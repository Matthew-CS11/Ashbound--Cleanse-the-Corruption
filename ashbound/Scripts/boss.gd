extends Node3D
var health =100
var on_fire
var isburned = false
func _on_area_3d_area_entered(area: Area3D) -> void:
	on_fire = true
	
func _process(delta: float) -> void:
	if on_fire == true:
		health-=5*delta
		print(health)
	if health<0:
		queue_free()
func _on_area_3d_area_exited(area: Area3D) -> void:
	on_fire = false
