extends CSGBox3D
var done = false
func _process(delta: float) -> void:
	if done:
		visible=false
