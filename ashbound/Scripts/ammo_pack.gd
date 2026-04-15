extends Node3D

signal picked_up

@onready var ammo_pack: Node3D = $"."
@onready var interact_label: Label3D = $interact_label

var player_is_in_area := false

func _process(delta: float) -> void:
	if player_is_in_area:
		if Input.is_action_just_pressed("interact"):
			picked_up.emit()
			print("mommy asmr")
			queue_free()

func _on_pickup_area_body_entered(body: Node3D) -> void:
	if body is Player:
		print("here")
		player_is_in_area = true
		interact_label.visible = true


func _on_pickup_area_body_exited(body: Node3D) -> void:
	player_is_in_area = false
	interact_label.visible = false
