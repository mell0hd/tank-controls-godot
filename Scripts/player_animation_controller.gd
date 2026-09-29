class_name PlayerAnimController
extends Node

@onready var animation: AnimationTree = $"../Model/AnimationTree"
@onready var state_machine: PlayerStateMachine = $"../PlayerStateMachine"
@onready var state = state_machine.current_state
@onready var states = state_machine.states

@export var blend_speed = 15

func handle_animations(delta):
	pass
func update_tree():
	animation["parameters/Locomotion Blend/blend_amount"]

func _ready():
	print(states)
		
		
#func update_tree():
	#animation["parameters/Locomotion Blend/blend_amount"] = 		
