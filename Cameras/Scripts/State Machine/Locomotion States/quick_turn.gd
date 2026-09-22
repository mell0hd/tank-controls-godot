extends PlayerState
class_name QuickTurnState

func enter():
	print(" ")
	print("entering quick turn")
	


	
#Frame Logic
func update(delta: float):
	pass

# Movement
func physics_update(delta: float):
	pass
	
	
	
#Player Input
func handle_input(event: InputEvent):
	#temporary remove this when you are ready to implement quick turn
	if Input.is_anything_pressed() == false:
		print(" ")
		print("exiting quick turn(not currently programmedw)")
		state_machine.change_state("idlestate")
