extends Node3D
@onready var label: Label = $UI/Label
func _ready() -> void:
	await get_tree().create_timer(4).timeout
	label.text = "the creature in front of you is a mold meister"
	await get_tree().create_timer(4).timeout
	label.text = "whats in your hand is your pistol,
	 you can shoot the mold meisters with this"
	await get_tree().create_timer(4).timeout
	label.text = "this is your flamethrower. do not use these on the 
	mold meisters, it will only make them stronger."
	await get_tree().create_timer(4).timeout
	$Enemy.visible=false
	$mold.visible=true
	label.text = "use the flamethrower to destroy and burn these viny growths
	of mold"
	get_tree().change_scene_to_file("res://Scenes/hospital.tscn")
