extends Node3D
signal burn

func _on_area_3d_area_entered(area: Area3D) -> void:
	pass


func _on_dry_4195_burned() -> void:
	burn.emit()
