extends Node3D
@onready var muzzle_flash: Node3D = $"."

var orig_x
var orig_y
var orig_z
var clear = true
func _ready():
	orig_x= position.x
	orig_y=position.y
	orig_z=position.z
	scale *= randf_range(2.9,3.1)
	rotation_degrees.z = randf_range(-10.0, 10.0)
	
func _process(delta: float) -> void:
	rotation_degrees.z+=5


func _on_timer_timeout() -> void:
	var x = randf_range(10,15)
	var tween = get_tree().create_tween()
	tween.tween_property(muzzle_flash,"position",Vector3(orig_x+x,orig_y+15,orig_z),1)
	tween.tween_property(muzzle_flash,"position",Vector3(orig_x-x,orig_y-15,orig_z),1)
