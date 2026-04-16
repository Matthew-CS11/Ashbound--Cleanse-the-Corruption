extends Node3D
var on_fire

func _on_area_3d_area_entered(_area: Area3D) -> void:
	on_fire = true

func _process(_delta: float) -> void:
	if on_fire == true:
		$Dry3333.transparency+=0.02
		$Dry8873LOD.transparency+=0.02
		$Dry8873LOD013.transparency+=0.02
		$Dry8873LOD014.transparency+=0.02


func _on_area_3d_area_exited(_area: Area3D) -> void:
	on_fire=false
