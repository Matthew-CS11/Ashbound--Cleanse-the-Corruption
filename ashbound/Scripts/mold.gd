extends Node3D
signal burn
var burned=false
func _on_area_3d_area_entered(area: Area3D) -> void:
	pass


func _on_dry_4195_burned() -> void:
	if burned==false:
		burn.emit()
		burned=true
