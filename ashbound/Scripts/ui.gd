extends CanvasLayer
class_name UI

@onready var ammo_label: Label = $Ammo_HUD/VBoxContainer/ammo_label
@onready var texture_progress_bar: TextureProgressBar = $Level_progress/TextureProgressBar


func update_ammo_label(current, reserve):
	$Ammo_HUD/VBoxContainer/ammo_label.text = str(current) +" / "+ str(reserve)
