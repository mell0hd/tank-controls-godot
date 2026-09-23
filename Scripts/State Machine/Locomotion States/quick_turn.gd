class_name QuickTurnState

extends PlayerState

func enter():
	print(" ")
	print("entering quick turn")
	if not is_quick_turning:
		quickTurn()
		print("exiting quick turn change state")
		state_machine.change_state("idlestate")
		QuickTurnDone.connect(state_machine.change_state(""))
		
	


	
#Frame Logic
func update(delta: float):
	pass

# Movement
func physics_update(delta: float):
	if is_quick_turning:
		player.velocity.x = 0
		player.velocity.z = 0

#Player Input
func handle_input(event: InputEvent):
	pass
	#temporary remove this when you are ready to implement quick turn
	if Input.is_anything_pressed() == false:
		print(" ")
		print("exiting quick no input")
		state_machine.change_state("idlestate")
