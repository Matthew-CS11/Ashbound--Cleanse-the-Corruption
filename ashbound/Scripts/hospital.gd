extends Node3D
@onready var label: Label = $UI/Label
func _ready() -> void:
	$AudioStreamPlayer.volume_db = -10
	await get_tree().create_timer(2).timeout
	label.text = "search around these backrooms and burn all the vines."
	await get_tree().create_timer(3.5).timeout
	label.text = "remember to protect yourself from enemies with your gun"
	await get_tree().create_timer(3.5).timeout
	$UI/ColorRect.visible=false
	$UI/Label.visible=false
	$AudioStreamPlayer.volume_db = 6
