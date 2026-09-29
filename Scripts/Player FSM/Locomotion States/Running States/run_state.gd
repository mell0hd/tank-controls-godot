class_name RunState
extends PlayerState

func enter():
	print(" ")
	print("entered run state")
	


# Movement
func _physics_process(delta: float) -> void:
	handleTurn(delta)
	if Input.is_action_pressed("run"):
		handleRun(delta)
		
	else:
		state_machine.change_state("idlestate")
	
	if is_quick_turning:
		state_machine.change_state("quickturnstate")
	player.move_and_slide()
#Player Input
func handle_input(event: InputEvent):
	pass
