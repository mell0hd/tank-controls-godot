class_name IdleState
extends PlayerState


func enter():
	print("entered idle state")
	#print(state_machine)
	

func _physics_process(delta: float) -> void:
	pass

# Movement
func physics_update(delta: float):
	handleTurn(delta)
	
	
#Player Input
func handle_input(event: InputEvent):
	if Input.is_anything_pressed() == true:
		if Input.is_action_pressed("move_forward") or Input.is_action_pressed("turn_left") or Input.is_action_pressed("turn_right") or Input.is_action_pressed("move_backward"):
			state_machine.change_state("walkstate")
		if Input.is_action_pressed("run"):
				state_machine.change_state("runstate")
			
		if Input.is_action_pressed("quick_turn"):
			state_machine.change_state("quickturnstate")
	
		
