extends Node3D
@onready var label: Label = $UI/Label
signal boii
signal boii2
signal boii3
func _ready() -> void:
	boii3.emit()
	await get_tree().create_timer(4).timeout
	label.text = "the creature in front of you is a mold meister"
	await get_tree().create_timer(4).timeout
	boii.emit()
	label.text = "whats in your hand is your pistol,
	 you can shoot the mold meisters with this"
	await get_tree().create_timer(4).timeout
	boii2.emit()
	label.text = "this is your flamethrower. do not use these on the 
	mold meisters, it will only make them stronger."
	await get_tree().create_timer(5.5).timeout
	$Enemy.visible=false
	$mold.visible=true
	label.text = "use the flamethrower to destroy and burn these viny growths
	of mold"
	await get_tree().create_timer(6).timeout
	label.text = "good luck"
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/hospital.tscn")
