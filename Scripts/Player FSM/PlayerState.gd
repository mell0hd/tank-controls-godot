extends CharacterBody3D
class_name PlayerState



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
	player.move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	pass
	

#Player Input
func handle_input(event: InputEvent):
	pass
#-------------------- virtual functinos
