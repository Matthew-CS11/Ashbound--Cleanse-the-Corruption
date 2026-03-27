extends CharacterBody3D
class_name Enemy

@export var max_health := 50
@export var damage: int = 25


@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: Player = $"../player"

var agro := false
var health : int

signal killed

func _ready() -> void:
	health = max_health
	
func take_damage(amt: int) -> void:
	health -= amt
	if health <= 0:
		killed.emit()
		queue_free()

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

#func handle_hit(hit: Dictionary) -> void:
	#var c = hit.collider
	#
	#if c is Area3D:
		#var a := c as Area3D
		#if a.is_in_group("damage_area"):
			#var enemy = a.owner
			#if enemy and enemy.has_method("take_damage"):
				#enemy.take_damage(damage)
			#return
			#
	#if c is Node and (c as Node).has_method("take_damage"):
		#(c as Node).take_damage(damage)
		#return
