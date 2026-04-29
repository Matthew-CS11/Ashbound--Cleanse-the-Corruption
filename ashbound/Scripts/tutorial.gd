extends Node3D
@onready var label: Label = $UI/Label
func _ready() -> void:
	await get_tree().create_timer(3).timeout
	label.text = "this is your gun, you can shoot the mold meisters with this"
	await get_tree().create_timer(3).timeout
	label.text = "this is your flamethrower. do not use these on the 
	mold meisters, it will only make them stronger."
	await get_tree().create_timer(3).timeout
	label.text = "use the flamethrower to destroy and burn these viny growths
	of mold"
