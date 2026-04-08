extends CanvasLayer
class_name UI

@onready var ammo_label: Label = $Ammo_HUD/VBoxContainer/ammo_label


func update_ammo_label(current, reserve):
	$Ammo_HUD/VBoxContainer/ammo_label.text = str(current) +" / "+ str(reserve)
