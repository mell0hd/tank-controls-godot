extends CharacterBody3D
class_name PlayerState

#States
enum {IDLE,RUN_FORWARD, RUN_BACKWARD, RUN_STRAFE_RIGHT, RUN_STRAFE_LEFT,WALK_FORWARD,WALK_BACKWARD,WALK_STRAFE_RIGHT,WALK_STRAFE_LEFT,CROUCH,TURN,CROUCHING,LOCOMOTION}
var current_state = IDLE



# Animation Position Values -- values to set the current animation 
#F = forward
#B = backward
#SR = strafe right
#SL = strafe left
#I = Idle

#-----------------Specifc Run/Walk Blends
var run_val := Vector2(0.0,1.0)
var walk_val := Vector2(0.0,1.0)
var crouch_val = 0.0

#------------------State Blends
var turn_val = 0.0
var crouching_val = 0.0
var locomotion_val = 0.0

#-----------------Blend Speed
var blend_speed = .8

#-----------------Basic Movement Variables
@export_group("Movement Settings")
@export var turn_speed := 180.0
#time it takes to quick turn in seconds
const quick_turn_speed := .3
@export var walk_speed := 80.0
@export var run_speed := 280.0


const GRAVITY = -9.81
var is_quick_turning = false

#----------------------Reference Variables
var state_machine: PlayerStateMachine
@onready var player: Player = $"../../../Player"
@onready var animation: AnimationTree = $"../../../Player/Model/AnimationTree"



#created own methods that child states can use and override

#----------------------movement functions
func handleTurn(delta):
	# makes a direction called turn direction and its equal to axis input values that we've assigned turn left and turn right
	# gives a value from 0-1 for each of the listed inputs.
	var turn_direction = Input.get_axis("turn_left","turn_right")
	player.rotation_degrees.y -= turn_direction * turn_speed * delta

func quickTurn():
	is_quick_turning = true
	
	var _target_y_rotation = player.rotation.y + PI

	var tween = create_tween() as Tween
	#interpolates between current rotation and new rotation by quick turn speed
	tween.tween_property(player,"rotation:y", _target_y_rotation, quick_turn_speed)
	#when tween is finished turns is quick turning back to false
	tween.finished.connect(func(): is_quick_turning = false)
	#tween.finished.connect(_on_tween_finished)
	
func handleWalk(delta):	
	#creates a value based on -1-0,0-1, so increases or decreases value based on what you're pressing?
	var input_direction = Input.get_axis("move_backward","move_forward")
	
	#basis.z is where-ever the character is facing at all times
	var walk_velocity = (player.basis.z * -1) * input_direction * walk_speed * delta
	player.velocity.x = walk_velocity.x
	player.velocity.z = walk_velocity.z
	
	
func handleRun(delta):
	#creates a value based on -1-0,0-1, so increases or decreases value based on what you're pressing
	var input_strength = Input.get_axis("move_backward","move_forward")
	
	#basis.z is where-ever the character is faceing at all times
	var walk_velocity = (player.basis.z * -1) * input_strength * run_speed * delta
	player.velocity.x = walk_velocity.x
	player.velocity.z = walk_velocity.z

func handleGravity(delta):
	if is_on_floor():
		player.velocity.y = -2
	else:
		player.velocity.y += GRAVITY * delta 
#---------------------------end of movement functions

#---------------------------virtual functions for children

#Everything in here is set to 0 which means it will automatically idle, change these for various states
func handleAnimation(delta):
	match current_state:
		IDLE:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 0.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
				#turn value will be handled in functin "handleTurn()"
		RUN_FORWARD:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,1.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
				#turn value will be handled in functin "handleTurn()"
	
#updates the animation tree to change animations based on values assigned earlier
func update_tree():
	# States Animations
	animation.set("parameters/Locomotion Blend/blend_amount", locomotion_val)
	animation.set("parameters/Crouch Blend/blend_position", crouching_val)
	animation.set("parameters/Turn Blend/blend_amount", turn_val )
	
	# Specific Animations Run/Walk/Crouch
	
	animation.set("parameters/Walk Locomotion/blend_position", walk_val )
	animation.set("parameters/Run Locomotion/blend_position", run_val )
	animation.set("parameters/Crouching Locomotion/blend_position", crouch_val )

# Initilization
func enter():
	pass
	
# Cleanup	
func exit():
	pass
	
#Frame Logic
func update(delta: float):
	pass

# Movement
func physics_update(delta: float):
	pass

#temp add see if it fixes movement?
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	pass
	

#Player Input
func handle_input(event: InputEvent):
	pass
#-------------------- virtual functinos
