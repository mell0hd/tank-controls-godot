class_name WalkState
extends PlayerState




# Initilization
func enter():
	print(" ")
	print("entered walk state")
	

func update(delta: float):
	pass
	
	
func physics_update(delta: float):
	pass
func _physics_process(delta: float) -> void:
	
	handleWalk(delta)
	handleTurn(delta)
	
	
	player.move_and_slide()

#Player Input
func handle_input(event: InputEvent):
	
	
# State Transitions
	if Input.is_action_pressed("quick_turn"):
		state_machine.change_state("quickturnstate")
		
	elif Input.is_action_pressed("run"):
		state_machine.change_state("runstate")
				
	elif Input.is_anything_pressed() == false:
			state_machine.change_state("idlestate")
