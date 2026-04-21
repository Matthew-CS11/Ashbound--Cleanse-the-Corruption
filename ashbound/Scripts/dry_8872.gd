extends Node3D
var on_fire

func _on_area_3d_area_entered(area: Area3D) -> void:
	on_fire = true

func _process(delta: float) -> void:
	if on_fire == true:
		$Dry8872.transparency+=0.02
		$Dry8873LOD.transparency+=0.02
		$Dry8873LOD011.transparency+=0.02
		$Dry8873LOD012.transparency+=0.02

	


func _on_area_3d_area_exited(area: Area3D) -> void:
	on_fire = false
