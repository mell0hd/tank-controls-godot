extends CharacterBody3D
#class_name Player
# Basic Movement Variables
@export_group("Movement Settings")
@export var turn_speed := 180.0
#time it takes to quick turn in seconds
const quick_turn_speed := .3
@export var walk_speed := 80.0
@export var run_speed := 280.0


const GRAVITY = -9.81
var is_quick_turning = false
var t = 0.0

@export_group("Animation Settings")
@onready var animation_player = $Player/AnimationPlayer
var default_blend_time = 0.5





#function that handles turning input
func handleTurn(delta):
	# makes a direction called turn direction and its equal to axis input values that we've assigned turn left and turn right
	# gives a value from 0-1 for each of the listed inputs.
	var turn_direction = Input.get_axis("turn_left","turn_right")
	rotation_degrees.y -= turn_direction * turn_speed * delta

func quickTurn():
	is_quick_turning = true
	
	
	var _target_y_rotation = rotation.y + PI

	var tween = create_tween() as Tween
	#interpolates between current rotation and new rotation by quick turn speed
	tween.tween_property(self,"rotation:y", _target_y_rotation, quick_turn_speed)
	#when tween is finished turns is quick turning back to false
	tween.finished.connect(func(): is_quick_turning = false)
	
func handleWalk(delta):
	#creates a value based on -1-0,0-1, so increases or decreases value based on what you're pressing
	var input_direction = Input.get_axis("move_backward","move_forward")
	#basis.z is where-ever the character is facing at all times
	
	var walk_velocity = -basis.z * input_direction * walk_speed * delta
	velocity.x = walk_velocity.x
	velocity.z = walk_velocity.z
	
func handleRun(delta):
	#creates a value based on -1-0,0-1, so increases or decreases value based on what you're pressing
	var input_strength = Input.get_axis("move_backward","move_forward")
	#basis.z is where-ever the character is faceing at all times
	var walk_velocity = -basis.z * input_strength * run_speed * delta
	velocity.x = walk_velocity.x
	velocity.z = walk_velocity.z

func handleGravity(delta):
	if is_on_floor():
		velocity.y = -2
	else:
		velocity.y += GRAVITY * delta 
#handles animation, incomplete as i want to learn a state machine instead of current method		
func handleAnimation():
	var input_vector = Input.get_vector("turn_left","turn_right","move_backward","move_forward")
	
	if input_vector == Vector2.ZERO:
		animation_player.play("mixamo_com",default_blend_time)
	
func _physics_process(delta: float) -> void:
	handleTurn(delta)
	handleWalk(delta)
	if Input.is_action_pressed("run"):
		handleRun(delta)
		
	else:
		handleWalk(delta)
	
	if is_quick_turning:
		
		velocity.x = 0
		velocity.z = 0
	
	
	handleGravity(delta)
	#moves character based on set velocity!!
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	pass
	if Input.is_action_just_pressed("quick_turn") and not is_quick_turning:
		quickTurn()
