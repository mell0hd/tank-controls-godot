extends CharacterBody3D
class_name PlayerState



#Basic Movement Variables
@export_group("Movement Settings")
@export var turn_speed := 180.0
#time it takes to quick turn in seconds
const quick_turn_speed := .3
@export var walk_speed := 80.0
@export var run_speed := 280.0


const GRAVITY = -9.81
var is_quick_turning = false

#Reference Variables
var state_machine: StateMachine
@onready var player = $Player


#created own methods that child states can use and override

#----------------------movement functions
func handleTurn(delta):
	# makes a direction called turn direction and its equal to axis input values that we've assigned turn left and turn right
	# gives a value from 0-1 for each of the listed inputs.
	var turn_direction = Input.get_axis("turn_left","turn_right")
	rotation_degrees.y -= turn_direction * turn_speed * delta

func quickTurn():
	#temporary replace when you are ready to implement quick turn
	pass
	
func handleWalk(delta):	
	#creates a value based on -1-0,0-1, so increases or decreases value based on what you're pressing?
	var input_direction = Input.get_axis("move_backward","move_forward")
	
	#basis.z is where-ever the character is facing at all times
	#if I remove player.velocity nothing happens when it is called in its various states.  
	#if i add player.velocity then i get the error "Invalid acces to property or key 'velocity on a base object of type 'Nill'/"null instance"' etc
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
	move_and_slide()

#Player Input
func handle_input(event: InputEvent):
	pass
