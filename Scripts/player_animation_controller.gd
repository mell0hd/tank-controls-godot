class_name PlayerAnimController
extends Node

@onready var animation: AnimationTree = $"../Model/AnimationTree"
@onready var state_machine: PlayerStateMachine = $"../PlayerStateMachine"
@onready var state = state_machine.current_state
@onready var states = state_machine.states

@onready var current_anim = IDLE
#crouch is for either crouch idle / crouch walk
#cruoching is for if you are either crouching or standing

#locomotion decides between walk run and idle
enum {IDLE\
,RUN,RUN_FORWARD, RUN_BACKWARD, RUN_STRAFE_RIGHT, RUN_STRAFE_LEFT\
,WALK,WALK_FORWARD,WALK_BACKWARD,WALK_STRAFE_RIGHT,WALK_STRAFE_LEFT,\
CROUCH_IDLE, CROUCH_WALK,TURN,CROUCHING}


#-----------------Specifc Run/Walk Blends
var run_val := Vector2(0.0,1.0)
var walk_val := Vector2(0.0,1.0)
var crouch_val = 0.0

#------------------State Blends
var turn_val = 0.0
var crouching_val = 0.0
var locomotion_val = 0.0

#-----------------Blend Speed
@export var blend_speed = .8


func handleAnimation(delta):
	match current_anim:
		IDLE:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 0.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
				#turn value will be handled in functin "handleTurn()"
		RUN:
			locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
			crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
			crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
		RUN_FORWARD:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,1.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
		RUN_BACKWARD:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,-1.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
		RUN_STRAFE_LEFT:
			#specific animations
				run_val.x = lerpf(run_val.x ,1.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
		RUN_STRAFE_RIGHT:
			#specific animations
				run_val.x = lerpf(run_val.x ,-1.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)	
		WALK:
			locomotion_val = lerpf(locomotion_val, -1.0, blend_speed*delta)
			crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
			crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
		WALK_FORWARD:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,1.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, -1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
		WALK_BACKWARD:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,-1.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, -1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
		WALK_STRAFE_LEFT:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,-1.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, -1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
		WALK_STRAFE_RIGHT:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,1.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, -1.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)	
		CROUCH_IDLE:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 0.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,1.0,blend_speed*delta)	
		CROUCH_WALK:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 1.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 0.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,1.0,blend_speed*delta)	
		CROUCHING:
			#specific animations
				run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
				run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
				walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
				walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
				crouch_val = lerpf(crouch_val, 0.0,blend_speed*delta)
			#state animatinos
				locomotion_val = lerpf(locomotion_val, 0.0, blend_speed*delta)
				crouching_val = lerpf(crouching_val ,1.0,blend_speed*delta)	

func update_tree():
	# States Animations
	animation.set("parameters/Locomotion Blend/blend_amount", locomotion_val)
	animation.set("parameters/Crouch Blend/blend_position", crouching_val)
	animation.set("parameters/Turn Blend/blend_amount", turn_val )
	
	# Specific Animations Run/Walk/Crouch
	
	animation.set("parameters/Walk Locomotion/blend_position", walk_val )
	animation.set("parameters/Run Locomotion/blend_position", run_val )
	animation.set("parameters/Crouching Locomotion/blend_position", crouch_val )

func _ready():
	print(states)
		
		
#func update_tree():
	#animation["parameters/Locomotion Blend/blend_amount"] = 		
