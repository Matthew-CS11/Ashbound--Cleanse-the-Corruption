extends Node3D

var on_fire

func _on_area_3d_area_entered(area: Area3D) -> void:
	on_fire = true
	
func _process(delta: float) -> void:
	$Dry4195.transparency+=0.02
	$Dry8873LOD.transparency+=0.02
	$Dry8873LOD007.transparency+=0.02
	$Dry8873LOD008.transparency+=0.02
