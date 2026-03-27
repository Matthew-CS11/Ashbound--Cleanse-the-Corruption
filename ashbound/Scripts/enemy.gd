extends CharacterBody3D
class_name Enemy

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: Player = $"../player"

var agro := false

func _process(_delta: float) -> void:
	if agro:
		navigation_agent_3d.set_target_position(player.global_position)
		look_at(player.global_position)


func _physics_process(_delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var direction = (destination - global_position).normalized()
	
	
	velocity = direction * 5.0
	
	move_and_slide()



func _on_aggression_radius_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("meow")
		agro = true
