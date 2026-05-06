extends Node3D

@onready var label: Label = $UI/Text_bar/Label

func _ready() -> void:
	$AudioStreamPlayer.volume_db = -10
	await get_tree().create_timer(2).timeout
	label.text = "search around these backrooms and burn all the vines."
	await get_tree().create_timer(3.5).timeout
	label.text = "remember to protect yourself from enemies with your gun"
	await get_tree().create_timer(3.5).timeout
	$UI/Text_bar.visible=false
	$UI/Text_bar/Label.visible=false
	$AudioStreamPlayer.volume_db = 6
