extends CharacterBody3D
class_name State

var state_machine: StateMachine

#created own methods that child states can use and override

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
	
#Player Input
func handle_input(event: InputEvent):
	pass
