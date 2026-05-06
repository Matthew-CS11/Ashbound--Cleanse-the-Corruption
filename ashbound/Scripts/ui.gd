extends CanvasLayer
class_name UI

@onready var ammo_label: Label = $Ammo_HUD/VBoxContainer/ammo_label
@onready var health_label: Label = $Health_HUD/HBoxContainer/Health_label


func update_ammo_label(current, reserve):
	$Ammo_HUD/VBoxContainer/ammo_label.text = str(current) +" / "+ str(reserve)

func update_health_label(amt) -> void:
	health_label.text = str(amt)
