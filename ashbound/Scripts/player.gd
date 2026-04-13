extends CharacterBody3D
class_name Player

const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const SPRINT_VELOCITY = 1.5
const BOB_WALK_SPEED = 14.0
const BOB_SPRINT_SPEED = 22.0
const BOB_INTENSITY = .50

@export var max_health := 50

@onready var neck: Node3D = $Neck
@onready var camera_3d: Camera3D = $Neck/Camera3D
@onready var fps_knife: Node3D = $"Neck/Camera3D/fps-knife"
@onready var fps_c_19: Node3D = $"Neck/Camera3D/fps-c19"
@onready var fps_ak: Node3D = $"Neck/Camera3D/fps-ak"
@onready var knife_animation_tree: AnimationTree = $"Neck/Camera3D/fps-knife/AnimationTree"
@onready var pistol_animation_tree: AnimationTree = $"Neck/Camera3D/fps-c19/AnimationTree"
@onready var ak_animation_tree: AnimationTree = $"Neck/Camera3D/fps-ak/AnimationTree"
@onready var animation_player: AnimationPlayer = $"Neck/Camera3D/fps-knife/AnimationPlayer"
@onready var ui: UI = $"../UI"

var head_bob_vector = Vector2.ZERO
var head_bob_index = 0.0
var health : int
var num = 1

func _ready() -> void:
	health = max_health
	
#func take_damage(amt: int) -> void:
	#health -= amt
	#if health <= 0:
		#die()

func _process(delta: float) -> void:
	var state_machine = knife_animation_tree.get("parameters/playback")
	var state_machinep = pistol_animation_tree.get("parameters/playback")
	var state_machinea = ak_animation_tree.get("parameters/playback")
	
	if Input.is_action_just_pressed("MWdown"):
		num +=1
		if num>3:
			num=1
		if num == 1:
			state_machine.travel("take")
			fps_knife.visible=true
			fps_c_19.visible=false
			fps_ak.visible=false
		if num ==2:
			state_machinep.travel("take")
			fps_knife.visible=false
			fps_c_19.visible=true
			fps_ak.visible=false
		if num==3:
			state_machinea.travel("take")
			fps_knife.visible=false
			fps_c_19.visible=false
			fps_ak.visible=true
	if Input.is_action_just_pressed("MWup"):
		num -=1
		if num<1:
			num=3
		if num == 1:
			state_machine.travel("take")
			fps_knife.visible=true
			fps_c_19.visible=false
			fps_ak.visible=false
		if num ==2:
			state_machinep.travel("take")
			fps_knife.visible=false
			fps_c_19.visible=true
			fps_ak.visible=false
		if num==3:
			state_machinea.travel("take")
			fps_knife.visible=false
			fps_c_19.visible=false
			fps_ak.visible=true
	if Input.is_action_pressed("left click"):
		if num == 1:
			state_machine.travel("fire")
		if num == 3:
			state_machinea.travel("fire")
			$"Neck/Camera3D/fps-ak/MuzzleFlash".visible=true
			$"Neck/Camera3D/fps-ak/MuzzleFlash/Area3D/CollisionShape3D2".disabled=false
			$"Neck/Camera3D/fps-ak/MuzzleFlash/Area3D/CollisionShape3D".disabled=false
	else:
		$"Neck/Camera3D/fps-ak/MuzzleFlash".visible=false
		$"Neck/Camera3D/fps-ak/MuzzleFlash/Area3D/CollisionShape3D2".disabled=true
		$"Neck/Camera3D/fps-ak/MuzzleFlash/Area3D/CollisionShape3D".disabled=true
	if Input.is_action_just_pressed("left click"):
		if num == 2:
			if not fps_c_19.is_reloading:
				if fps_c_19.can_shoot():
					state_machinep.travel("fire")
					fps_c_19.shoot()
			else: 
				print("pistol empty")
	
	if Input.is_action_pressed("right click"):
		if num == 1:
			state_machine.travel("melee")
		if num == 2:
			state_machinep.travel("melee")
		if num == 3:
			state_machinea.travel("melee")
			
	if Input.is_action_just_pressed("reload"):
		if num == 2:
			fps_c_19.reload()
			pistol_animation_tree.get("parameters/playback").travel("reload")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * .01)
			camera_3d.rotate_x(-event.relative.y * .01)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_VELOCITY * 2)
	var bob_speed = BOB_WALK_SPEED

	head_bob_index += bob_speed * delta
	
	var new_y = sin(head_bob_index) * BOB_INTENSITY
	var new_x = cos(head_bob_index * 0.5) * BOB_INTENSITY
		
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		camera_3d.position.y = lerp(camera_3d.position.y, camera_3d.position.y + new_y, 0.1)
		camera_3d.position.x = lerp(camera_3d.position.x, camera_3d.position.x + new_x, 0.1)
		
		#checking for sprint
		#if Input.is_action_pressed("sprint"):
			#velocity.z *= SPRINT_VELOCITY
			#velocity.x *= SPRINT_VELOCITY
			##headbob
			#camera_3d.position.y = lerp(camera_3d.position.y, camera_3d.position.y + new_y, 0.1)
			#bob_speed = BOB_SPRINT_SPEED
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		camera_3d.position.y = lerp(camera_3d.position.y, 0.0, 0.1)
		camera_3d.position.x = lerp(camera_3d.position.x, 0.0, 0.1)

	move_and_slide()

#func die():
	#if lose_screen:
		#lose_screen.visible = true
		#lose_screen.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		#get_tree().paused = true
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#if cross:
			#cross.visible = false
		#if ui:
			#ui.visible = false
	#else:
		#get_tree().change_scene_to_file("res://lose_screen.tscn")
	


func _on_timer_timeout() -> void:
	pass # Replace with function body.
