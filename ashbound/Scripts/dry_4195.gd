extends Node3D

var on_fire
var isburned = false
signal burned
func _on_area_3d_area_entered(area: Area3D) -> void:
	on_fire = true
	
func _process(delta: float) -> void:
	if on_fire == true:
		$Dry4195.transparency+=0.02
		$Dry8873LOD.transparency+=0.02
		$Dry8873LOD007.transparency+=0.02
		$Dry8873LOD008.transparency+=0.02
	if $Dry8873LOD008.transparency>.99:
		if isburned == false:
			print("low")
			burned.emit()
			isburned=true
	if $Dry8873LOD008.transparency==1:
		get_parent().queue_free()
func _on_area_3d_area_exited(area: Area3D) -> void:
	on_fire = false
